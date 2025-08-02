import 'package:flutter/material.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../widgets/fifa_rating.dart';
import '../widgets/matches_card.dart';
import '../widgets/matches_top_tab.dart';
import '../widgets/qr_display_dialog.dart';
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
          if (tabIndex == 0) const ActiveMatchCard(
            title: 'Чемпионат мира 2025',
            team1Name: 'Казахстан',
            team2Name: 'Уэльс',
            team1LogoUrl: 'https://kff.kz/uploads/images/2018/07/09/5b43518120706_avatar.png',
            team2LogoUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Flag_of_Wales.svg/800px-Flag_of_Wales.svg.png',
            score: '0:0',
            timer: '47:00',
            isLive: true,
          ),
          if (tabIndex == 1) Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: MainTitleWidget(title: 'Ваши билеты'),
                ),
                TicketCard(
                  league: "Лига чемпионов",
                  dateTime: "29 июля | 23:30",
                  team1Name: "Елимай",
                  team2Name: "Арсенал",
                  team1LogoUrl: "https://upload.wikimedia.org/wikipedia/ru/thumb/4/40/FC_Elimay_Logo.svg/250px-FC_Elimay_Logo.svg.png",
                  team2LogoUrl: "https://upload.wikimedia.org/wikipedia/ru/thumb/5/53/Arsenal_FC.svg/250px-Arsenal_FC.svg.png",
                  onBuyPressed: () {},
                  onMyTicketPressed: () {
                    showModalBottomSheet<void>(
                      useRootNavigator: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          color: Colors.white,
                          child: QrDisplayDialog(
                            qrData: "https://example.com/your-ticket-id",
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Доступные билеты',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TicketCard(
                  league: "Лига чемпионов",
                  dateTime: "05 августа | 21:30",
                  team1Name: "Жетысу",
                  team2Name: "Барселона",
                  team1LogoUrl: "https://upload.wikimedia.org/wikipedia/ru/thumb/b/b2/%D0%A4%D0%9A_%D0%96%D0%B5%D1%82%D1%8B%D1%81%D1%83.png/250px-%D0%A4%D0%9A_%D0%96%D0%B5%D1%82%D1%8B%D1%81%D1%83.png",
                  team2LogoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/Barcelona_Sporting_Club_Logo.png/250px-Barcelona_Sporting_Club_Logo.png",
                  onBuyPressed: () {},
                  onMyTicketPressed: () {
                    showModalBottomSheet<void>(
                      useRootNavigator: true,
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: 400,
                          color: Colors.white,
                          child: QrDisplayDialog(
                            qrData: "https://example.com/your-ticket-id",
                            onClose: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    );
                  },
                ),
                // можно ещё TicketCard() для других матчей
              ],
            ),
          ),
          if (tabIndex == 2) Expanded(child: ListView(
            children: [
              FifaRankingList(
                title: "Рейтинг Фифа на 31 июля",
                entries: [
                  FifaRankingEntry(position: 1, country: "Аргентина", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Flag_of_Argentina.svg/250px-Flag_of_Argentina.svg.png"),
                  FifaRankingEntry(position: 2, country: "Италия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/03/Flag_of_Italy.svg/250px-Flag_of_Italy.svg.png"),
                  FifaRankingEntry(position: 3, country: "Франция", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Flag_of_France.svg/250px-Flag_of_France.svg.png"),
                  FifaRankingEntry(position: 4, country: "Англия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/be/Flag_of_England.svg/250px-Flag_of_England.svg.png"),
                  FifaRankingEntry(position: 5, country: "Бразилия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Flag_of_Brazil.svg/250px-Flag_of_Brazil.svg.png"),
                  FifaRankingEntry(position: 6, country: "Португалия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Flag_of_Portugal_%28official%29.svg/250px-Flag_of_Portugal_%28official%29.svg.png"),
                  FifaRankingEntry(position: 7, country: "Нидерланды", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Flag_of_the_Netherlands.svg/250px-Flag_of_the_Netherlands.svg.png"),
                  FifaRankingEntry(position: 8, country: "Бельгия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Flag_of_Belgium.svg/250px-Flag_of_Belgium.svg.png"),
                  FifaRankingEntry(position: 9, country: "Испания", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/Bandera_de_Espa%C3%B1a.svg/250px-Bandera_de_Espa%C3%B1a.svg.png"),
                  FifaRankingEntry(position: 10, country: "Германия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Flag_of_Germany.svg/250px-Flag_of_Germany.svg.png"),
                  FifaRankingEntry(position: 11, country: "Австрия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Flag_of_Austria.svg/250px-Flag_of_Austria.svg.png"),
                  FifaRankingEntry(position: 12, country: "Норвегия", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d9/Flag_of_Norway.svg/250px-Flag_of_Norway.svg.png"),
                  FifaRankingEntry(position: 12, country: "Польша", logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Flag_of_Poland.svg/250px-Flag_of_Poland.svg.png"),
                ],
              )
            ],
          ))

          // Здесь добавляй контент для других вкладок
        ],
      ),
    );
  }
}