import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import '../../l10n/app_localizations.dart';
import 'custom_navbar.dart';

class MainNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainNavigation({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      backgroundColor: Colors.white,
      bottomNavigationBar: CustomNavBarWidgetV2(
        navBarConfig: NavBarConfig(
          selectedIndex: navigationShell.currentIndex,
          onItemSelected: (index) {
            navigationShell.goBranch(
              index,
              initialLocation: index == navigationShell.currentIndex,
            );
          },
          items: _buildNavItems(context),
        ),
      ),
    );
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
