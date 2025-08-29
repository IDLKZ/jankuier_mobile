import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_category_entity.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/utils/file_utils.dart';
import '../../../../shared/widgets/main_title_widget.dart';
import '../bloc/product_category/product_category_bloc.dart';
import '../bloc/product_category/product_category_state.dart';

class ProductCategoryBottomScheet extends StatefulWidget {
  const ProductCategoryBottomScheet({super.key});

  @override
  State<ProductCategoryBottomScheet> createState() =>
      _ProductCategoryBottomScheetState();
}

class _ProductCategoryBottomScheetState
    extends State<ProductCategoryBottomScheet> {
  RangeValues _currentRange = const RangeValues(1000, 1000000);
  final TextEditingController _minController =
      TextEditingController(text: "9990");
  final TextEditingController _maxController =
      TextEditingController(text: "150000");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllProductCategoryBloc, AllProductCategoryState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MainTitleWidget(title: "Новые товары"),
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
                            if (state is AllProductCategoryLoadedState) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15.r),
                                      topLeft: Radius.circular(15.r),
                                    )),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.h, horizontal: 15.w),
                                    child: Column(
                                      children: [
                                        MainTitleWidget(title: "Категории"),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        DynamicHeightGridView(
                                            itemCount:
                                                state.productCategories.length,
                                            crossAxisCount: 3,
                                            crossAxisSpacing: 10.w,
                                            mainAxisSpacing: 10.h,
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            builder: (ctx, index) {
                                              ProductCategoryEntity
                                                  productCategory = state
                                                      .productCategories[index];
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    height: 70,
                                                    width: 70,
                                                    decoration:
                                                        const BoxDecoration(
                                                      color: Color(0xFFF5F6FA),
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child: Center(
                                                      child: productCategory
                                                                  .image !=
                                                              null
                                                          ? Image.network(
                                                              ApiConstant.GetImageUrl(
                                                                  productCategory
                                                                          .image
                                                                          ?.filePath ??
                                                                      ""),
                                                              width: 32,
                                                              height: 32,
                                                              fit: BoxFit
                                                                  .contain,
                                                            )
                                                          : Image.asset(
                                                              FileUtils
                                                                  .LocalProductImage,
                                                              // 🔑 твоя картинка
                                                              width: 32,
                                                              height: 32,
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                    ),
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Text(
                                                    "${productCategory.titleRu}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return Column(
                                              children: [
                                                RangeSlider(
                                                  values: _currentRange,
                                                  min: 1000,
                                                  max: 10000000,
                                                  divisions: 1000,
                                                  activeColor: Colors.blue,
                                                  onChanged:
                                                      (RangeValues values) {
                                                    setModalState(() {
                                                      _currentRange = values;
                                                      _minController.text =
                                                          values.start
                                                              .toInt()
                                                              .toString();
                                                      _maxController.text =
                                                          values.end
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
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: "от",
                                                          border:
                                                              OutlineInputBorder(),
                                                          isDense: true,
                                                        ),
                                                        onChanged: (val) {
                                                          final parsed =
                                                              int.tryParse(val);
                                                          if (parsed != null) {
                                                            setModalState(() {
                                                              _currentRange =
                                                                  RangeValues(
                                                                      parsed
                                                                          .toDouble(),
                                                                      _currentRange
                                                                          .end);
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
                                                            TextInputType
                                                                .number,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: "до",
                                                          border:
                                                              OutlineInputBorder(),
                                                          isDense: true,
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
                                                                      parsed
                                                                          .toDouble());
                                                            });
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Row(children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF0247C3),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 12.h),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              child: Text(
                                                "Применить",
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              width: double.infinity,
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
