import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:jankuier_mobile/core/utils/file_utils.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_product_parameter.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_event.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_state.dart';

import '../../../../core/constants/app_route_constants.dart';

class ProductGridCards extends StatefulWidget {
  const ProductGridCards({
    super.key,
  });

  @override
  State<ProductGridCards> createState() => _ProductGridCardsState();
}

class _ProductGridCardsState extends State<ProductGridCards> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {},
      builder: (context, state) {
        // Достаём данные, если они есть
        List<ProductEntity> items = const [];
        int totalItems = 0;
        int currentPage = 1;
        int? totalPages;

        if (state is PaginateProductLoadedState) {
          items = state.products;
          totalItems = state.pagination.totalItems;
          currentPage = state.pagination.currentPage;
          totalPages = state.pagination.totalPages; // если есть
        }

        // ✅ корректное определение последней страницы
        final bool isLastPage = totalPages != null
            ? currentPage >= totalPages!
            : items.length >= totalItems;

        // Первый лоад первой страницы
        if (state is PaginateProductLoadingState)
          return const Center(child: CircularProgressIndicator());

        // Контент
        return Stack(
          children: [
            DynamicHeightGridView(
              itemCount: items.length,
              crossAxisCount: 2,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 10.h,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(), // скроллит внешний
              builder: (ctx, index) {
                final p = items[index];
                return ProductCard(
                  imageWidget: FileUtils.getProductImage(p.image),
                  title: p.titleRu ?? '',
                  price: '${p.basePrice} ₸',
                  buttonText: 'Добавить в корзину',
                  onPressed: () {
                    context.push(
                        "${AppRouteConstants.SingleProductPagePath}${p.id}");
                  },
                );
              },
            ),

            // 🔄 Индикатор "догружаем следующую страницу"
            if (!isLastPage && state is PaginateProductLoadingState)
              const Positioned(
                left: 0,
                right: 0,
                bottom: 12,
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        );
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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
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
