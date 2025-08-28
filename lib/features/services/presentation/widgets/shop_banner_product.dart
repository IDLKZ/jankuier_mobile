import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/recommended_product/recommended_product_bloc.dart';

import '../../../../core/constants/api_constants.dart';
import '../bloc/recommended_product/recommended_product_state.dart';

class ShopBannerProduct extends StatelessWidget {
  const ShopBannerProduct({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecommendedProductBloc, RecommendedProductState>(
      builder: (context, state) {
        if (state is RecommendedProductLoadedState) {
          if (state.pagination.totalItems > 0) {
            ProductEntity productEntity = state.pagination.items.first;
            return ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: Container(
                height: 160.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: productEntity.image != null
                          ? Image.network(
                              ApiConstant.GetImageUrl(
                                  productEntity.image!.filePath),
                              fit: BoxFit.none,
                            )
                          : Image.asset(
                              FileUtils.LocalProductImage,
                              fit: BoxFit.none,
                            ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 16.w,
                      right: 16.w,
                      bottom: 16.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Текст
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${productEntity.titleRu}",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "${productEntity.basePrice} KZT",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: 12.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          // Кнопка
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Colors.white),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () {},
                            child: Text("Купить"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        }
        return SizedBox();
      },
    );
  }
}
