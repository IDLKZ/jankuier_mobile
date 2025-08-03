import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';

class TopTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabs;
  final ValueChanged<int> onTabSelected;

  const TopTabBar({
    Key? key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isActive = i == selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(i),
              child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: isActive ? Colors.white : AppColors.primary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
