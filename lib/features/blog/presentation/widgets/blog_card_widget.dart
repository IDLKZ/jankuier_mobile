import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';

class NewsCard extends StatelessWidget {
  final String imageUrl;
  final String tag;
  final String title;
  final String date;
  final int likes;
  final VoidCallback? onTap;

  const NewsCard({
    Key? key,
    required this.imageUrl,
    required this.tag,
    required this.title,
    required this.date,
    required this.likes,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2.w, vertical: 4.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Картинка
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  imageUrl,
                  width: 90,
                  height: 70,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 10),
              // Текстовая часть
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Тег
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Заголовок
                    Text(
                      title,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13.sp,
                        color: Colors.black
                      ),
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
              ),
            ],
          ),
          // Лайки и дата
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite_border,
                      size: 18, color: Colors.grey[400]),
                  const SizedBox(width: 4),
                  Text(
                    likes.toString(),
                    style: TextStyle(
                      color: const Color(0xFFBDBDBD),
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Text(
                  date,
                  style: TextStyle(
                    color: const Color(0xFFBDBDBD),
                    fontSize: 12.5.sp,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
