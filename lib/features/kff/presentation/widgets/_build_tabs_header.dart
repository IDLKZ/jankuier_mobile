import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

/// Строит таб для выбора типа данных (матчи, игроки, тренеры)
/// Параметры:
/// [title] - название таба
/// [index] - индекс таба
/// [icon] - иконка таба
Widget buildDataTab(String title, int index, IconData icon, TabController dataTabController) {
  final isSelected = dataTabController.index == index;

  return GestureDetector(
    onTap: () => dataTabController.animateTo(index),
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        gradient: isSelected ? AppColors.primaryGradient : null,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14.sp,
            color: isSelected ? AppColors.white : AppColors.textSecondary,
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
            ),
          ),
        ],
      ),
    ),
  );
}