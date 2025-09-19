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
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        IconTheme(
          data: IconThemeData(
            size: 22,
            color: isSelected ? (Colors.black) : (Colors.grey),
          ),
          child: item.icon,
        ),
        const SizedBox(height: 2),
        Text(
          item.title ?? "",
          style: TextStyle(
            fontSize: 10,
            color: isSelected ? (Colors.black) : (Colors.grey),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80 + MediaQuery.of(context).padding.bottom,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: EdgeInsets.fromLTRB(0, 12, 0, MediaQuery.of(context).padding.bottom + 8),
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
    );
  }

  void _navigateToTab(BuildContext context, int index) {
    final routes = ['/', '/tickets', '/services', '/blog', '/profile'];
    if (index < routes.length) {
      context.go(routes[index]);
    }
  }
}
