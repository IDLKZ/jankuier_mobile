import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductGridCards extends StatelessWidget {
  const ProductGridCards({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicHeightGridView(
        itemCount: 16,
        crossAxisCount: 2,
        crossAxisSpacing: 10.w,
        mainAxisSpacing: 10.h,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        builder: (ctx, index) {
          if (index % 2 == 0) {
            return ProductCard(
              imagePath: 'assets/images/product_2.png',
              title: 'Шорты “Сборная Казахстана”',
              price: '4900.00 ₸',
              buttonText: 'Добавить в корзину',
              onPressed: () {
                // Обработка нажатия
              },
            );
          } else {
            return ProductCard(
              imagePath: 'assets/images/shop_banner.png',
              title: 'Футболка “Сборная Казахстана”',
              price: '9900.00 ₸',
              buttonText: 'Добавить в корзину',
              onPressed: () {
                // Обработка нажатия
              },
            );
          }
        });
  }
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String price;
  final String buttonText;
  final VoidCallback onPressed;

  const ProductCard({
    super.key,
    required this.imagePath,
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
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              imagePath,
              width: double.infinity,
              height: 120.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
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
