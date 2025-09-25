import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_academy_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/use_cases/academy/paginate_academy_case.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_state.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../../../../core/common/entities/city_entity.dart';
import '../../../../../core/constants/app_route_constants.dart';
import '../../../../../core/di/injection.dart';
import '../../../../countries/domain/parameters/get_city_parameter.dart';
import '../../../../countries/domain/use_cases/get_cities_case.dart';
import '../../../../countries/presentation/bloc/get_cities_bloc/get_cities_bloc.dart';
import '../../../../countries/presentation/bloc/get_cities_bloc/get_cities_event.dart';
import '../../../../countries/presentation/bloc/get_cities_bloc/get_cities_state.dart';
import '../../../data/entities/academy/academy_entity.dart';
import '../section_card.dart';

class SectionMain extends StatefulWidget {
  const SectionMain({super.key});

  @override
  State<SectionMain> createState() => _SectionMainState();
}

class _SectionMainState extends State<SectionMain>
    with AutomaticKeepAliveClientMixin {
  late final GetCitiesBloc _getCitiesBloc;

  // Controllers and state for filters
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _minAgeController = TextEditingController();
  final TextEditingController _maxAgeController = TextEditingController();
  final TextEditingController _minPriceController = TextEditingController();
  final TextEditingController _maxPriceController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _searchError;
  CityEntity? _selectedCity;
  int _selectedGender = 0; // 0-любой, 1-мужской, 2-женский

  final dropDownKey = GlobalKey<DropdownSearchState>();
  PaginateAcademyParameter _params = PaginateAcademyParameter(perPage: 12);

  late final AcademyBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = AcademyBloc(
      paginateAcademyCase: getIt<PaginateAcademyCase>(),
    )..add(PaginateAcademyEvent(_params));
    _getCitiesBloc = GetCitiesBloc(getCitiesCase: getIt<GetCitiesCase>())
      ..add(GetCitiesEvent(const CityFilterParameter()));
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _bloc.close();
    _getCitiesBloc.close();
    _searchController.dispose();
    _minAgeController.dispose();
    _maxAgeController.dispose();
    _minPriceController.dispose();
    _maxPriceController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  String? _validateSearch(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Пустое поле разрешено
    }
    if (value.length < 3) {
      return 'Минимум 3 символа';
    }
    if (value.length > 255) {
      return 'Максимум 255 символов';
    }
    return null;
  }

  void _applyFilters() {
    final searchValue = _searchController.text.trim();
    final searchValidation = _validateSearch(searchValue);

    setState(() {
      _searchError = searchValidation;
    });

    if (searchValidation != null) {
      return; // Не применяем фильтры при ошибке валидации
    }

    // Парсим возрастные ограничения
    final minAge = int.tryParse(_minAgeController.text.trim());
    final maxAge = int.tryParse(_maxAgeController.text.trim());

    // Парсим ценовые ограничения
    final minPrice = double.tryParse(_minPriceController.text.trim());
    final maxPrice = double.tryParse(_maxPriceController.text.trim());

    // Обновляем параметры и сбрасываем на первую страницу
    _params = _params.copyWith(
      search: searchValue.isEmpty ? null : searchValue,
      cityIds: _selectedCity != null ? [_selectedCity!.id] : null,
      gender: _selectedGender == 0 ? null : _selectedGender,
      minAgeTo: minAge,
      maxAgeTo: maxAge,
      averagePriceFrom: minPrice,
      averagePriceTo: maxPrice,
      page: 1, // Сброс на первую страницу
    );

    // Запускаем новый поиск
    _bloc.add(PaginateAcademyEvent(_params));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more academies when near the bottom
      final currentState = _bloc.state;

      if (currentState is PaginateAcademyLoadedState) {
        final pagination = currentState.pagination;
        if (pagination.currentPage < pagination.totalPages) {
          // Load next page
          final nextPageParameter = _params.copyWith(
            page: pagination.currentPage + 1,
          );
          _bloc.add(PaginateAcademyEvent(nextPageParameter));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // ⚡ обязательно для AutomaticKeepAliveClientMixin
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<AcademyBloc, AcademyState>(
        builder: (context, state) {
          if (state is PaginateAcademyLoadedState) {
            return SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const MainTitleWidget(title: "Запись в секцию"),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                useRootNavigator: false,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  return StatefulBuilder(
                                    builder: (context, setModalState) {
                                      return DraggableScrollableSheet(
                                        initialChildSize: 0.6,
                                        maxChildSize: 0.8,
                                        minChildSize: 0.4,
                                        expand: false,
                                        builder: (_, scrollController) {
                                          return Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                                vertical: 30.h),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15.r),
                                                topLeft: Radius.circular(15.r),
                                              ),
                                            ),
                                            child: SingleChildScrollView(
                                              controller: scrollController,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // Title
                                                  Text(
                                                    'Фильтры поиска',
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppColors.black
                                                    ),
                                                  ),
                                                  SizedBox(height: 20.h),

                                                  // Search field
                                                  TextField(
                                                    controller:
                                                        _searchController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Поиск',
                                                      hintText:
                                                          'Введите название секции...',
                                                      border:
                                                          const OutlineInputBorder(),
                                                      errorText: _searchError,
                                                      prefixIcon:
                                                          const Icon(Icons.search),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    onChanged: (value) {
                                                      setModalState(() {
                                                        _searchError =
                                                            _validateSearch(
                                                                value);
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(height: 15.h),

                                                  // City selector
                                                  BlocProvider.value(
                                                    value: _getCitiesBloc,
                                                    child: BlocBuilder<
                                                        GetCitiesBloc,
                                                        GetCitiesState>(
                                                      builder:
                                                          (BuildContext context,
                                                              GetCitiesState
                                                                  state) {
                                                        if (state
                                                            is GetCitiesLoadingState) {
                                                          return const Center(
                                                            child:
                                                                CircularProgressIndicator(),
                                                          );
                                                        }
                                                        if (state
                                                            is GetCitiesSuccessState) {
                                                          return DropdownSearch<
                                                              CityEntity>(
                                                            key: dropDownKey,
                                                            selectedItem:
                                                                _selectedCity,
                                                            onChanged: (item) {
                                                              setModalState(() {
                                                                _selectedCity =
                                                                    item;
                                                              });
                                                            },
                                                            itemAsString:
                                                                (city) => city
                                                                    .titleRu,
                                                            compareFn: (item1,
                                                                    item2) =>
                                                                item1.id ==
                                                                item2.id,
                                                            filterFn: (CityEntity
                                                                    city,
                                                                String filter) {
                                                              final query = filter
                                                                  .toLowerCase();
                                                              return (city
                                                                      .titleRu
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          query)) ||
                                                                  ((city.titleKk ??
                                                                          "")
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          query)) ||
                                                                  ((city.titleEn ??
                                                                          "")
                                                                      .toLowerCase()
                                                                      .contains(
                                                                          query));
                                                            },
                                                            items: (filter, infiniteScrollProps) => state.cities,
                                                            decoratorProps:
                                                                const DropDownDecoratorProps(
                                                              decoration: InputDecoration(
                                                                labelText: 'Выберите город',
                                                                border: OutlineInputBorder(),
                                                                prefixIcon: Icon(Icons.location_city),
                                                                filled: true,
                                                                fillColor: Colors.white,
                                                              ),
                                                            ),
                                                            popupProps:
                                                                PopupProps.menu(
                                                              constraints:
                                                                  BoxConstraints(
                                                                      maxHeight:
                                                                          200.h),
                                                              showSelectedItems:
                                                                  false,
                                                              showSearchBox:
                                                                  true,
                                                              fit:
                                                                  FlexFit.loose,
                                                              itemBuilder: (context,
                                                                      item,
                                                                      isDisabled,
                                                                      isSelected) =>
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        12.0),
                                                                child: Text(
                                                                  item.titleRu,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14.sp),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                        return const SizedBox();
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 15.h),

                                                  // Gender selector
                                                  DropdownButtonFormField<int>(
                                                    value: _selectedGender,
                                                    decoration: const InputDecoration(
                                                      labelText: 'Пол',
                                                      labelStyle: TextStyle(color: AppColors.black),
                                                      border:
                                                          OutlineInputBorder(),
                                                      prefixIcon:
                                                          Icon(Icons.person),
                                                      filled: true,
                                                      fillColor: Colors.white,
                                                    ),
                                                    items: const [
                                                      DropdownMenuItem(
                                                          value: 0,
                                                          child: Text('Любой')),
                                                      DropdownMenuItem(
                                                          value: 1,
                                                          child:
                                                              Text('Мужской')),
                                                      DropdownMenuItem(
                                                          value: 2,
                                                          child:
                                                              Text('Женский')),
                                                    ],
                                                    onChanged: (value) {
                                                      setModalState(() {
                                                        _selectedGender =
                                                            value ?? 0;
                                                      });
                                                    },
                                                  ),
                                                  SizedBox(height: 15.h),

                                                  // Age range
                                                  Text(
                                                    'Возраст',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.black
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _minAgeController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: 'От',
                                                            border:
                                                                OutlineInputBorder(),
                                                            isDense: true,
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _maxAgeController,
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText: 'До',
                                                            border:
                                                                OutlineInputBorder(),
                                                            isDense: true,
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 15.h),

                                                  // Price range
                                                  Text(
                                                    'Средняя цена',
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.black
                                                    ),
                                                  ),
                                                  SizedBox(height: 8.h),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _minPriceController,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                      decimal:
                                                                          true),
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Цена от',
                                                            border:
                                                                OutlineInputBorder(),
                                                            isDense: true,
                                                            suffixText: '₸',
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width: 10.w),
                                                      Expanded(
                                                        child: TextField(
                                                          controller:
                                                              _maxPriceController,
                                                          keyboardType:
                                                              const TextInputType
                                                                  .numberWithOptions(
                                                                      decimal:
                                                                          true),
                                                          decoration:
                                                              const InputDecoration(
                                                            labelText:
                                                                'Цена до',
                                                            border:
                                                                OutlineInputBorder(),
                                                            isDense: true,
                                                            suffixText: '₸',
                                                            filled: true,
                                                            fillColor: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 25.h),

                                                  // Apply button
                                                  SizedBox(
                                                    width: double.infinity,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        _applyFilters();
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color(
                                                                0xFF0247C3),
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 15.h),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.r),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        'Применить',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: Icon(
                              Iconsax.filter_square_copy,
                              size: 18.sp,
                            ))
                      ]),
                  SizedBox(height: 12.h),
                  _buildAcademyList(state.academies, state),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildAcademyList(
      List<AcademyEntity> academies, PaginateAcademyLoadedState state) {
    final pagination = state.pagination;
    final bool hasMorePages = pagination.currentPage < pagination.totalPages;

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: academies.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return SectionCardWidget(
              entity: academies[index],
              onTap: () {
                context.push(
                  "${AppRouteConstants.ServiceSectionSinglePagePath}${academies[index].id}",
                );
              },
            );
          },
        ),

        // Индикатор загрузки дополнительных страниц
        BlocBuilder<AcademyBloc, AcademyState>(
          builder: (context, currentState) {
            if (hasMorePages &&
                currentState is PaginateAcademyLoadingState &&
                academies.isNotEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        // Сообщение о том, что больше секций нет
        if (!hasMorePages && academies.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'Больше секций нет',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
          ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
