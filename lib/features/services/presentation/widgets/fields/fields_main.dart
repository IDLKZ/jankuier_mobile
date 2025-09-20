import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/common/entities/city_entity.dart';
import 'package:jankuier_mobile/features/countries/domain/use_cases/get_cities_case.dart';
import 'package:jankuier_mobile/features/countries/presentation/bloc/get_cities_bloc/get_cities_bloc.dart';
import 'package:jankuier_mobile/features/countries/presentation/bloc/get_cities_bloc/get_cities_event.dart';
import 'package:jankuier_mobile/features/countries/presentation/bloc/get_cities_bloc/get_cities_state.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_party_parameter.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_state.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../shared/widgets/main_title_widget.dart';
import '../../../../countries/domain/parameters/get_city_parameter.dart';
import '../../../domain/use_cases/field/paginate_field_party_case.dart';
import '../../bloc/field_party/field_party_bloc.dart';
import '../field_card.dart';

class FieldsMain extends StatefulWidget {
  const FieldsMain({super.key});

  @override
  State<FieldsMain> createState() => _FieldsMainState();
}

class _FieldsMainState extends State<FieldsMain>
    with AutomaticKeepAliveClientMixin {
  late final FieldPartyBloc _bloc;
  late final GetCitiesBloc _getCitiesBloc;
  final dropDownKey = GlobalKey<DropdownSearchState>();
  PaginateFieldPartyParameter _params = PaginateFieldPartyParameter(
      orderBy: "field_id", orderDirection: "desc", perPage: 12);

  // Controllers and state for filters
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  CityEntity? _selectedCity;
  String? _searchError;

  @override
  void initState() {
    super.initState();
    _bloc = FieldPartyBloc(
      paginateFieldPartyCase: getIt<PaginateFieldPartyCase>(),
    )..add(PaginateFieldPartyEvent(_params));
    _getCitiesBloc = GetCitiesBloc(getCitiesCase: getIt<GetCitiesCase>())
      ..add(GetCitiesEvent(const CityFilterParameter()));

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _bloc.close();
    _getCitiesBloc.close();
    _searchController.dispose();
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

    // Обновляем параметры и сбрасываем на первую страницу
    _params = _params.copyWith(
      search: searchValue.isEmpty ? null : searchValue,
      cityId: _selectedCity?.id,
      page: 1, // Сброс на первую страницу
    );

    // Запускаем новый поиск
    _bloc.add(PaginateFieldPartyEvent(_params));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more field parties when near the bottom
      final currentState = _bloc.state;

      if (currentState is PaginateFieldPartyLoadedState) {
        final pagination = currentState.pagination;
        if (pagination.currentPage < pagination.totalPages) {
          // Load next page
          final nextPageParameter = _params.copyWith(
            page: pagination.currentPage + 1,
          );
          _bloc.add(PaginateFieldPartyEvent(nextPageParameter));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // важно для AutomaticKeepAliveClientMixin
    return BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<FieldPartyBloc, FieldPartyState>(
          builder: (context, state) {
            if (state is PaginateFieldPartyLoadedState) {
              final fieldParties = state.fieldParties;

              return SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(context),
                    SizedBox(height: 15.h),
                    _buildFieldList(fieldParties, state),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const MainTitleWidget(title: "Аренда полей"),
        IconButton(
          icon: Icon(Iconsax.filter_square_copy, size: 18.sp),
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
                              horizontal: 20.w, vertical: 30.h),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Title
                                Text(
                                  'Фильтры поиска',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20.h),

                                // Search field
                                TextField(
                                  controller: _searchController,
                                  decoration: InputDecoration(
                                    labelText: 'Поиск',
                                    hintText: 'Введите название поля...',
                                    border: OutlineInputBorder(),
                                    errorText: _searchError,
                                    prefixIcon: Icon(Icons.search),
                                  ),
                                  onChanged: (value) {
                                    setModalState(() {
                                      _searchError = _validateSearch(value);
                                    });
                                  },
                                ),
                                SizedBox(height: 15.h),

                                // City selector
                                BlocProvider.value(
                                  value: _getCitiesBloc,
                                  child: BlocBuilder<GetCitiesBloc,
                                      GetCitiesState>(
                                    builder: (BuildContext context,
                                        GetCitiesState state) {
                                      if (state is GetCitiesLoadingState) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }
                                      if (state is GetCitiesSuccessState) {
                                        return DropdownSearch<CityEntity>(
                                          key: dropDownKey,
                                          selectedItem: _selectedCity,
                                          onChanged: (item) {
                                            setModalState(() {
                                              _selectedCity = item;
                                            });
                                          },
                                          itemAsString: (city) => city.titleRu,
                                          compareFn: (item1, item2) =>
                                              item1.id == item2.id,
                                          filterFn:
                                              (CityEntity city, String filter) {
                                            final query = filter.toLowerCase();
                                            return (city.titleRu
                                                    .toLowerCase()
                                                    .contains(query)) ||
                                                ((city.titleKk ?? "")
                                                    .toLowerCase()
                                                    .contains(query)) ||
                                                ((city.titleEn ?? "")
                                                    .toLowerCase()
                                                    .contains(query));
                                          },
                                          items:
                                              (filter, infiniteScrollProps) =>
                                                  state.cities,
                                          decoratorProps:
                                              DropDownDecoratorProps(
                                            decoration: InputDecoration(
                                              labelText: 'Выберите город',
                                              border: OutlineInputBorder(),
                                              prefixIcon:
                                                  Icon(Icons.location_city),
                                            ),
                                          ),
                                          popupProps: PopupProps.menu(
                                            constraints: BoxConstraints(
                                                maxHeight: 200.h),
                                            showSelectedItems: false,
                                            showSearchBox: true,
                                            fit: FlexFit.loose,
                                            itemBuilder: (context, item,
                                                    isDisabled, isSelected) =>
                                                Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                item.titleRu,
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                              ),
                                            ),
                                          ),
                                        );
                                      }
                                      return SizedBox();
                                    },
                                  ),
                                ),
                                SizedBox(height: 25.h),

                                // Apply button
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _applyFilters();
                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0247C3),
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                      ),
                                    ),
                                    child: Text(
                                      'Применить',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
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
        ),
      ],
    );
  }

  Widget _buildFieldList(List<FieldPartyEntity> fieldParties,
      PaginateFieldPartyLoadedState state) {
    final pagination = state.pagination;
    final bool hasMorePages = pagination.currentPage < pagination.totalPages;

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: fieldParties.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            return FieldCard(fieldPartyEntity: fieldParties[index]);
          },
        ),

        // Индикатор загрузки дополнительных страниц
        BlocBuilder<FieldPartyBloc, FieldPartyState>(
          builder: (context, currentState) {
            if (hasMorePages &&
                currentState is PaginateFieldPartyLoadingState &&
                fieldParties.isNotEmpty) {
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

        // Сообщение о том, что больше полей нет
        if (!hasMorePages && fieldParties.isNotEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'Больше полей нет',
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
