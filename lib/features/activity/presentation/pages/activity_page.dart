import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../domain/entities/Achievement.dart';
import '../../domain/entities/Leader.dart';
import '../widgets/activity_page_widget.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
        title: AppLocalizations.of(context)!.activity,
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
      ),
      body: const ActivityPageWidget(
        visitedMatches: 250,
        achievements: [
          Achievement(
              title: 'Легионер', iconAsset: 'assets/icons/legioner.png'),
          Achievement(title: 'Фанат', iconAsset: 'assets/icons/fan.png'),
          Achievement(title: 'Чемпион', iconAsset: 'assets/icons/cup.png'),
          Achievement(title: 'Test', iconAsset: 'assets/icons/cup.png'),
        ],
        leaders: [
          LeaderEntry(
              position: 1,
              name: 'Айжан Нурсултанова',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 2,
              name: 'Асхат Ермеков',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 3,
              name: 'Нуржан Тулеов',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 4,
              name: 'Батыpхан Арматов',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 5,
              name: 'Айжан Нурсултанова',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 6,
              name: 'Асхат Ермеков',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 7,
              name: 'Нуржан Тулеов',
              iconAsset: 'assets/icons/medal_blue.png'),
          LeaderEntry(
              position: 8,
              name: 'Батыpхан Арматов',
              iconAsset: 'assets/icons/medal_blue.png'),
        ],
      ),
    );
  }
}
