import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';

class FieldsSortingFilter extends StatelessWidget {
  const FieldsSortingFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _buildFilterChildren(context),
    );
  }

  List<Widget> _buildFilterChildren(BuildContext context) {
    return [
      Text(
        'Астана: 256 сооружений',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),
      ),
      SizedBox(height: 12.h),
      Row(
        children: [
          Expanded(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.primaryLight),
                foregroundColor: AppColors.primaryLight,
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              onPressed: () {},
              child: Text(
                "Добавить площадку",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: OutlinedButton.icon(
              icon: Icon(Icons.filter_list, size: 16.sp),
              iconAlignment: IconAlignment.end,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF838383)),
                foregroundColor: const Color(0xFF838383),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3.r),
                ),
              ),
              onPressed: () {},
              label: Text(
                "Фильтры",
                style: TextStyle(
                  fontFamily: "Inter",
                  fontSize: 11.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      SizedBox(height: 12.h),
      Text(
        'Поиск свободного времени',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black
        ),
      ),
      SizedBox(height: 12.h),
      Row(
        children: [
          _timeFilterButton(context, "1 сентября"),
          SizedBox(width: 10.w),
          _timeFilterButton(context, "20:00"),
          SizedBox(width: 10.w),
          _timeFilterButton(context, "21:00"),
        ],
      ),
    ];
  }

  Widget _timeFilterButton(BuildContext context, String label) {
    return Expanded(
      child: OutlinedButton.icon(
        icon: Icon(Icons.keyboard_arrow_down_sharp, size: 16.sp),
        iconAlignment: IconAlignment.end,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black),
          foregroundColor: Colors.black,
          padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.w),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        onPressed: () {},
        label: Text(
          label,
          style: TextStyle(
            fontFamily: "Inter",
            fontSize: 11.sp,
          ),
        ),
      ),
    );
  }
}
