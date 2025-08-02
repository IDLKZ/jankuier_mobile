import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Container(
        color: const Color(0xFFF6F7F9),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.only(top: 0, left: 16, right: 16),
              child: Text(
                'Активность',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(height: 10),
            // Card: Посещенных матчей
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
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
                height: 180,
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
                          const SizedBox(height: 4),
                          Text(
                            '$visitedMatches',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const Text(
                            'посещённых матчей',
                            style: TextStyle(
                              fontSize: 14,
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
            const SizedBox(height: 18),
            // Мои достижения
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Мои достижения',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        const SizedBox(height: 4),
                        Text(
                          a.title,
                          style: const TextStyle(fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
            const SizedBox(height: 20),
            // Список лидеров
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Список лидеров',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: leaders
                    .map(
                      (e) => Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Row(
                      children: [
                        Text(
                          e.position.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            e.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
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
                  ),
                )
                    .toList(),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}