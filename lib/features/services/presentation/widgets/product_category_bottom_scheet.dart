import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/utils/localization_helper.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_category_entity.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/main_title_widget.dart';
import '../../domain/parameters/paginate_product_parameter.dart';
import '../bloc/product/product_bloc.dart';
import '../bloc/product/product_event.dart';
import '../bloc/product_category/product_category_bloc.dart';
import '../bloc/product_category/product_category_state.dart';

class ProductCategoryBottomScheet extends StatefulWidget {
  final Function(List<int> categoryIds, int? minPrice, int? maxPrice)?
      onFiltersApplied;

  const ProductCategoryBottomScheet({
    super.key,
    this.onFiltersApplied,
  });

  @override
  State<ProductCategoryBottomScheet> createState() =>
      _ProductCategoryBottomScheetState();
}

class _ProductCategoryBottomScheetState
    extends State<ProductCategoryBottomScheet> {
  final Set<int> categoriesIds = <int>{};
  late TextEditingController _minController;
  late TextEditingController _maxController;
  RangeValues _currentRange = const RangeValues(1000, 1000000);

  @override
  void initState() {
    super.initState();
    _minController =
        TextEditingController(text: _currentRange.start.toInt().toString());
    _maxController =
        TextEditingController(text: _currentRange.end.toInt().toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductCategoryBloc, AllProductCategoryState>(
      builder: (context, state) {
        final productBloc = context.read<ProductBloc>();
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainTitleWidget(title: AppLocalizations.of(context)!.newProducts),
              IconButton(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      useRootNavigator: false,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (BuildContext context) {
                        return DraggableScrollableSheet(
                          initialChildSize: 0.6,
                          maxChildSize: 0.6,
                          minChildSize: 0.4,
                          expand: false,
                          builder: (_, scrollController) {
                            // локальный setState для содержимого шита
                            return StatefulBuilder(
                              builder: (context, setModalState) {
                                if (state is! AllProductCategoryLoadedState) {
                                  return const SizedBox.shrink();
                                }
                                final cats = state.productCategories;

                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.r),
                                      topLeft: Radius.circular(15.r),
                                    ),
                                  ),
                                  child: SingleChildScrollView(
                                    controller: scrollController, // ВАЖНО!
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15.h, horizontal: 15.w),
                                      child: Column(
                                        children: [
                                          MainTitleWidget(
                                              title:
                                                  AppLocalizations.of(context)!
                                                      .categories),
                                          SizedBox(height: 15.h),
                                          DynamicHeightGridView(
                                            itemCount: cats.length,
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10.w,
                                            mainAxisSpacing: 10.h,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            builder: (ctx, index) {
                                              final pc = cats[index];
                                              final selected = pc.id != null &&
                                                  categoriesIds.contains(pc.id);

                                              return GestureDetector(
                                                onTap: () {
                                                  setModalState(() {
                                                    if (pc.id == null) return;
                                                    if (categoriesIds
                                                        .contains(pc.id)) {
                                                      categoriesIds
                                                          .remove(pc.id);
                                                    } else {
                                                      categoriesIds.add(pc.id!);
                                                    }
                                                  });
                                                },
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Stack(
                                                      alignment:
                                                          Alignment.center,
                                                      children: [
                                                        Container(
                                                          height: 70,
                                                          width: 70,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: selected
                                                                ? AppColors
                                                                    .primaryLight
                                                                : const Color(
                                                                    0xFFF5F6FA),
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Center(
                                                            child: pc.image !=
                                                                    null
                                                                ? Image.network(
                                                                    ApiConstant.GetImageUrl(
                                                                        pc.image?.filePath ??
                                                                            ""),
                                                                    width: 32,
                                                                    height: 32,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  )
                                                                : Image.asset(
                                                                    FileUtils
                                                                        .LocalProductImage,
                                                                    width: 32,
                                                                    height: 32,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 8),
                                                    Text(
                                                      context.localizedDirectTitle(pc),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: selected
                                                            ? AppColors
                                                                .primaryLight
                                                            : Colors.black,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          SizedBox(height: 15.h),

                                          // ЦЕНЫ
                                          Column(
                                            children: [
                                              RangeSlider(
                                                values: _currentRange,
                                                min: 1000.0,
                                                max: 1000000.0,
                                                divisions: 1000,
                                                activeColor:
                                                    const Color(0xFF0247C3),
                                                onChanged:
                                                    (RangeValues values) {
                                                  setModalState(() {
                                                    _currentRange = values;
                                                    _minController.text = values
                                                        .start
                                                        .toInt()
                                                        .toString();
                                                    _maxController.text = values
                                                        .end
                                                        .toInt()
                                                        .toString();
                                                  });
                                                },
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          _minController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .from,
                                                        border:
                                                            OutlineInputBorder(),
                                                        isDense: true,
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      onChanged: (val) {
                                                        final parsed =
                                                            int.tryParse(val);
                                                        if (parsed != null) {
                                                          setModalState(() {
                                                            _currentRange =
                                                                RangeValues(
                                                              parsed.toDouble(),
                                                              _currentRange.end,
                                                            );
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          _maxController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      decoration:
                                                          InputDecoration(
                                                        labelText:
                                                            AppLocalizations.of(
                                                                    context)!
                                                                .to,
                                                        border:
                                                            OutlineInputBorder(),
                                                        isDense: true,
                                                        filled: true,
                                                        fillColor: Colors.white,
                                                      ),
                                                      onChanged: (val) {
                                                        final parsed =
                                                            int.tryParse(val);
                                                        if (parsed != null) {
                                                          setModalState(() {
                                                            _currentRange =
                                                                RangeValues(
                                                              _currentRange
                                                                  .start,
                                                              parsed.toDouble(),
                                                            );
                                                          });
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),

                                          SizedBox(height: 15.h),

                                          Row(
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    // Apply filters
                                                    final selectedCategories =
                                                        categoriesIds.toList();
                                                    final minPrice =
                                                        _currentRange.start
                                                            .toInt();
                                                    final maxPrice =
                                                        _currentRange.end
                                                            .toInt();

                                                    // Call the callback to update filters
                                                    if (widget
                                                            .onFiltersApplied !=
                                                        null) {
                                                      widget.onFiltersApplied!(
                                                        selectedCategories,
                                                        minPrice,
                                                        maxPrice,
                                                      );
                                                    }

                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        const Color(0xFF0247C3),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.h),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                    ),
                                                  ),
                                                  child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .apply,
                                                      style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.white)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
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
            ],
          ),
        );
      },
    );
  }
}
