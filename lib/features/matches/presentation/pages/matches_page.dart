import 'package:flutter/material.dart';

import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../widgets/matches_card.dart';
import '../widgets/matches_top_tab.dart';
import '../widgets/ticker_card.dart';

class MatchesPage extends StatefulWidget {
  const MatchesPage({super.key});

  @override
  State<MatchesPage> createState() => _MatchesPageState();
}

class _MatchesPageState extends State<MatchesPage> {
  int tabIndex = 0;

  final List<String> tabs = ["Активный матч", "Билеты", "Результаты"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesCommonAppBar(
        title: "Матчи",
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
      ),
      backgroundColor: const Color(0xFFF6F7F9),
      body: Column(
        children: [
          TopTabBar(
            selectedIndex: tabIndex,
            tabs: tabs,
            onTabSelected: (i) => setState(() => tabIndex = i),
          ),
          const SizedBox(height: 16),
          if (tabIndex == 0) const ActiveMatchCard(),
          if (tabIndex == 1) Expanded(
            child: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Ваши билеты',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TicketCard(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Доступные билеты',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TicketCard(),
                // можно ещё TicketCard() для других матчей
              ],
            ),
          ),
          // Здесь добавляй контент для других вкладок
        ],
      ),
    );
  }
}