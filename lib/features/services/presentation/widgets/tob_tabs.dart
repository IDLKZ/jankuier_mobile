import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceTopTabs extends StatelessWidget {
  final TabController controller;

  const ServiceTopTabs({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<_TabItemData> tabItems = [
      _TabItemData(
        icon: Icons.storefront_outlined,
        activeIcon: Icons.storefront,
        label: 'Магазин',
      ),
      _TabItemData(
        icon: Icons.map_outlined,
        activeIcon: Icons.map,
        label: 'Поля',
      ),
      _TabItemData(
        icon: Icons.group_outlined,
        activeIcon: Icons.group,
        label: 'Секции',
      ),
    ];

    return AnimatedBuilder(
      animation: controller.animation!,
      builder: (context, _) {
        final selectedIndex = controller.animation!.value.round();
        return Container(
          color: Colors.transparent,
          child: TabBar(
            dividerColor: Colors.transparent,
            controller: controller,
            indicatorColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            labelPadding: EdgeInsets.symmetric(vertical: 12.h),
            tabs: List.generate(
              tabItems.length,
              (i) => _RoundTab(
                tabItems[i],
                selected: selectedIndex == i,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TabItemData {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  const _TabItemData({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _RoundTab extends StatelessWidget {
  final _TabItemData tab;
  final bool selected;

  const _RoundTab(this.tab, {required this.selected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected ? Color(0xFFD6DEEE) : Color(0xFFD6DEEE),
          ),
          child: Icon(
            selected ? tab.activeIcon : tab.icon,
            size: 24.sp,
            color: selected ? Color(0xFF0A388C) : Color(0xFF7690BF),
          ),
        ),
        SizedBox(height: 6.h),
        Text(
          tab.label,
          style: TextStyle(
            fontSize: 13.sp,
            color: selected ? Colors.black : Color(0xFFA6A6A6),
            fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
