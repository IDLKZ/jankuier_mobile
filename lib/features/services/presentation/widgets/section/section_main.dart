import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../../../../core/constants/app_route_constants.dart';
import '../section_card.dart';

class SectionMain extends StatelessWidget {
  const SectionMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: MainTitleWidget(title: "Запись в секцию"),
              ),
              SizedBox(
                height: 12.w,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Icon(
                    Icons.filter_list,
                    size: 20.w,
                    color: Color(0xFF0148CA),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 12.h,
          ),
          SectionCardWidget(
            imagePath: 'assets/images/section_1.jpg',
            title: 'Match Astana - Футбольная секция',
            subtitle:
                'Футбольная секция Match Astana на летний сезон ведет набор.',
            duration: '90 минут',
            ageRange: 'до 10–13 лет',
            price: '15 000₸/месяц',
            address: 'Ул. Орынбор, Ботанический Сад, Левый берег, Астана',
            onTap: () {
              context.push(AppRouteConstants.ServiceSectionSinglePagePath);
            },
          ),
          SectionCardWidget(
            imagePath: 'assets/images/section_2.jpg',
            title: 'Junior Stars - Футбольная академия',
            subtitle:
                'Тренировки для детей от 6 до 12 лет с профессиональными тренерами.',
            duration: '60 минут',
            ageRange: '6–12 лет',
            price: '12 000₸/месяц',
            address: 'пр. Кабанбай батыра, 45, Астана',
            onTap: () {
              context.push(AppRouteConstants.ServiceSectionSinglePagePath);
            },
          ),
        ],
      ),
    );
  }
}
