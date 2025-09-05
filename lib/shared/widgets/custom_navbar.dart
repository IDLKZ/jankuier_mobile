import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class CustomNavBarWidgetV2 extends StatelessWidget {
  final NavBarConfig navBarConfig;

  const CustomNavBarWidgetV2({
    Key? key,
    required this.navBarConfig,
  }) : super(key: key);

  Widget _buildItem(ItemConfig item, bool isSelected) {
    return SizedBox(
      height: 80.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconTheme(
            data: IconThemeData(
              size: 24,
              color: isSelected ? (Colors.black) : (Colors.grey),
            ),
            child: item.icon,
          ),
          SizedBox(height: 4.h),
          Text(
            item.title ?? "",
            style: TextStyle(
              fontSize: 10.sp,
              color: isSelected ? (Colors.black) : (Colors.grey),
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
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: navBarConfig.items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              final isSelected = idx == navBarConfig.selectedIndex;

              return Expanded(
                child: Material(
                  color: Colors.transparent,
                  child: GestureDetector(
                    onTap: () {
                      _navigateToTab(context, idx);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: _buildItem(item, isSelected),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final routes = ['/', '/tickets', '/services', '/activity', '/profile'];
    if (index < routes.length) {
      context.go(routes[index]);
    }
  }
}
