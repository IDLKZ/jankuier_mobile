import 'package:flutter/material.dart';

class ActiveMatchCard extends StatelessWidget {
  final String title;
  final String team1Name;
  final String team2Name;
  final String team1LogoUrl;
  final String team2LogoUrl;
  final String score;
  final String timer;
  final bool isLive;
  final String? team1Subtitle;
  final String? team2Subtitle;

  const ActiveMatchCard({
    super.key,
    required this.title,
    required this.team1Name,
    required this.team2Name,
    required this.team1LogoUrl,
    required this.team2LogoUrl,
    required this.score,
    required this.timer,
    this.isLive = false,
    this.team1Subtitle,
    this.team2Subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Team 1
              Column(
                children: [
                  SizedBox(
                    height: 38,
                    width: 38,
                    child: Image.network(
                      team1LogoUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    team1Name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (team1Subtitle != null)
                    Text(
                      team1Subtitle!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
              // Счет и таймер
              Column(
                children: [
                  Text(
                    score,
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 14,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      timer,
                      style: const TextStyle(
                        color: Color(0xFF0057A0),
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              // Team 2
              Column(
                children: [
                  SizedBox(
                    height: 38,
                    width: 38,
                    child: Image.network(
                      team2LogoUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    team2Name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (team2Subtitle != null)
                    Text(
                      team2Subtitle!,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (isLive)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.fiber_manual_record, color: Colors.red, size: 14),
                SizedBox(width: 5),
                Text(
                  'Прямо эфир',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
