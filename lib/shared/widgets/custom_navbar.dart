import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  const CustomNavBarWidget({
    Key? key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
  }) : super(key: key);

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(
              size: 24,
              color: isSelected
                  ? (item.activeColorPrimary ?? Colors.black)
                  : (item.inactiveColorPrimary ?? Colors.grey),
            ),
            child: item.icon,
          ),
          SizedBox(height: 4.h),
          Text(
            item.title ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              color: isSelected
                  ? (item.activeColorPrimary ?? Colors.black)
                  : (item.inactiveColorPrimary ?? Colors.grey),
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.h,
      decoration: const BoxDecoration(
        color: Color(0xFFF6F7F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          final idx = entry.key;
          final item = entry.value;
          return Expanded(
            child: Material(
              color: Colors.transparent,
              child: GestureDetector(
                onTap: () => onItemSelected(idx),
                behavior: HitTestBehavior.opaque,
                child: _buildItem(item, selectedIndex == idx),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
