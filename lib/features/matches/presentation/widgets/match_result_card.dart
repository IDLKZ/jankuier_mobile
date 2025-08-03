import 'package:flutter/material.dart';

class MatchResultCard extends StatelessWidget {
  final String title;
  final String team1;
  final String team2;
  final String team1LogoUrl;
  final String team2LogoUrl;
  final String score;
  final String date;
  final double verticalPadding;
  final double horizontalPadding;
  final double verticalMargin;
  final double horizontalMargin;

  const MatchResultCard({
    Key? key,
    required this.title,
    required this.team1,
    required this.team2,
    required this.team1LogoUrl,
    required this.team2LogoUrl,
    required this.score,
    required this.date,
    this.horizontalPadding = 12,
    this.verticalPadding = 18,
    this.horizontalMargin = 12,
    this.verticalMargin = 18,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: verticalMargin, horizontal: horizontalMargin),
      padding: EdgeInsets.symmetric(vertical: verticalPadding, horizontal: horizontalPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.black
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Team 1
              Column(
                children: [
                  Text(
                    team1,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.network(
                      team1LogoUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Счет и дата
              Column(
                children: [
                  Text(
                    score,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              // Team 2
              Column(
                children: [
                  Text(
                    team2,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.black
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.network(
                      team2LogoUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
