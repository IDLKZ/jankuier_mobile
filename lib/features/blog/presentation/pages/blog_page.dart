import 'package:flutter/material.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../widgets/blog_card_widget.dart';

class BlogListPage extends StatelessWidget {
  const BlogListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesCommonAppBar(
        title: "Новости",
        actionIcon: Icons.notifications_none,
        onActionTap: () {},
      ),
      body: ListView(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: MainTitleWidget(title: 'Новости'),
              ),
              NewsCard(
                imageUrl: 'https://upload.wikimedia.org/wikipedia/ru/thumb/c/cd/Football_Federation_of_Kazakhstan_Logo.svg/200px-Football_Federation_of_Kazakhstan_Logo.svg.png',
                tag: 'Новости',
                title: 'МАРАТ ОМАРОВ: «МЫ ОФИЦИАЛЬНО ПОДАЛИ ЗАЯВКУ НА ПРОВЕДЕНИЕ ФИНАЛА ЛИГИ КОНФЕРЕНЦИЙ ИЛИ СУПЕРКУБКА»',
                date: '14 июля 2025, 15:30',
                likes: 234,
                onTap: () {
                  // обработка нажатия
                },
              )
            ],
          )
        ],
      ),
    );
  }
}