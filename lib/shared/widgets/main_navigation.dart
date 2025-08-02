import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

import '../../features/activity/presentation/pages/activity_page.dart';
import 'custom_navbar.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/matches/presentation/pages/matches_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0); // "Матчи" по дефолту

  List<CustomNavBarScreen> _buildScreens() => [
    const CustomNavBarScreen(screen: HomePage()),
    const CustomNavBarScreen(screen: MatchesPage()),
    const CustomNavBarScreen(screen: ServicesPage()),
    const CustomNavBarScreen(screen: ActivityPage()),
    const CustomNavBarScreen(screen: ProfilePage()),
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.home),
      title: "Главная",
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.sports_soccer),
      title: "Матчи",
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.dashboard_outlined),
      title: "Сервисы",
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.local_fire_department_outlined),
      title: "Активность",
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
    PersistentBottomNavBarItem(
      icon: const Icon(Icons.person),
      title: "Профиль",
      activeColorPrimary: Colors.black,
      inactiveColorPrimary: Colors.grey,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView.custom(
      context,
      controller: _controller,
      itemCount: _navBarsItems().length,
      screens: _buildScreens(),
      confineToSafeArea: true,
      backgroundColor: const Color(0xFFF6F7F9), // <-- светлый!
      hideNavigationBarWhenKeyboardAppears: true,
      customWidget: CustomNavBarWidget(
        selectedIndex: _controller.index,
        items: _navBarsItems(),
        onItemSelected: (index) {
          setState(() {
            _controller.index = index;
          });
        },
      ),
    );
  }
}
