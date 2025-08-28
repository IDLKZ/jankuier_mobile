import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';

import '../../../../core/constants/app_route_constants.dart';

class ProductGridCards extends StatelessWidget {
  const ProductGridCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is PaginateProductLoadingState) {
          return CircularProgressIndicator();
        }
        if (state is PaginateProductLoadedState) {
          return DynamicHeightGridView(
              itemCount: state.products.length,
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              builder: (ctx, index) {
                return ProductCard(
                  imageWidget:
                      FileUtils.getProductImage(state.products[index].image),
                  title: "${state.products[index].titleRu}",
                  price: '${state.products[index].basePrice} ₸',
                  buttonText: 'Добавить в корзину',
                  onPressed: () {
                    context.push(AppRouteConstants.SingleProductPagePath);
                  },
                );
              });
        }
        return SizedBox();
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  final Widget imageWidget;
  final String title;
  final String price;
  final String buttonText;
  final VoidCallback onPressed;

  const ProductCard({
    super.key,
    required this.imageWidget,
    required this.title,
    required this.price,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(8.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: imageWidget,
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
                foregroundColor: const Color(0xFF0247C3),
                side: const BorderSide(color: Color(0xFF0247C3)),
                padding: EdgeInsets.symmetric(vertical: 5.h),
              ),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 10.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
