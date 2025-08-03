import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/shared/widgets/main_title_widget.dart';

import '../../domain/entities/Achievement.dart';
import '../../domain/entities/Leader.dart';

class ActivityPageWidget extends StatelessWidget {
  final int visitedMatches;
  final List<Achievement> achievements;
  final List<LeaderEntry> leaders;

  const ActivityPageWidget({
    Key? key,
    required this.visitedMatches,
    required this.achievements,
    required this.leaders,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.only(top: 0, left: 16, right: 16),
              child: MainTitleWidget(title: 'Активность'),
            ),
            SizedBox(height: 10.h),
            // Card: Посещенных матчей
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF166CFF),
                    Color(0xFF0057A0),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: SizedBox(
                height: 180.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    // Круги
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/icons/activity_main_bg_lines.png'),
                          fit: BoxFit.fill,
                          alignment: Alignment.center
                        ),
                      ),
                    ),
                    // Контент
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/medal.png', // замени на свою иконку, либо svg
                            width: 100,
                            height: 100,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '$visitedMatches',
                            style: TextStyle(
                              fontSize: 32.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'посещённых матчей',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 18.h),
            // Мои достижения
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const MainTitleWidget(title: 'Мои достижения'),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: List.generate(achievements.length, (i) {
                  final a = achievements[i];
                  return Expanded(
                    child: Column(
                      children: [
                        Image.asset(
                          a.iconAsset,
                          width: 42,
                          height: 42,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          a.title,
                          style: TextStyle(fontSize: 12.sp, color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            SizedBox(height: 20.h),
            // Список лидеров
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: const MainTitleWidget(title: 'Список лидеров'),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: ListView.builder(
                  itemCount: leaders.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final e = leaders[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 4.h),
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 14.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Row(
                        children: [
                          Text(
                            e.position.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Colors.black
                            ),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Text(
                              e.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                              ),
                            ),
                          ),
                          Image.asset(
                            e.iconAsset,
                            width: 28,
                            height: 28,
                          ),
                        ],
                      ),
                    );
                  },
                )
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}