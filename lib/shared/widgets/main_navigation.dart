import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../l10n/app_localizations.dart';
import 'custom_navbar.dart';

class MainNavigation extends StatelessWidget {
  final Widget child;

  const MainNavigation({
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();
    final currentIndex = _getIndexFromRoute(currentRoute);

    return Scaffold(
      body: child,
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomNavBarWidgetV2(
        navBarConfig: NavBarConfig(
          selectedIndex: currentIndex,
          onItemSelected: (index) {
            // Navigation handled in CustomNavBarWidgetV2
          },
          items: _buildNavItems(context),
        ),
      ),
    );
  }

  int _getIndexFromRoute(String route) {
    switch (route) {
      case '/':
        return 0;
      case '/tickets':
        return 1;
      case '/services':
        return 2;
      case '/blog':
        return 3;
      case '/profile':
        return 4;
      default:
        return 0;
    }
  }

  List<ItemConfig> _buildNavItems(BuildContext context) {
    return [
      ItemConfig(
        icon: const Icon(Icons.home),
        title: AppLocalizations.of(context)!.home,
        activeColorSecondary: Colors.black,
      ),
      ItemConfig(
        icon: const Icon(Iconsax.ticket),
        title: AppLocalizations.of(context)!.tickets,
        activeColorSecondary: Colors.black,
      ),
      ItemConfig(
        icon: const Icon(Icons.dashboard_outlined),
        title: AppLocalizations.of(context)!.services,
        activeColorSecondary: Colors.black,
      ),
      ItemConfig(
        icon: const Icon(Icons.newspaper_outlined),
        title: AppLocalizations.of(context)!.news,
        activeColorSecondary: Colors.black,
      ),
      ItemConfig(
        icon: const Icon(Icons.person),
        title: AppLocalizations.of(context)!.profile,
        activeColorSecondary: Colors.black,
      ),
    ];
  }
}
