import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/app_localizations.dart';

class TicketCard extends StatelessWidget {
  final String league;
  final String dateTime;
  final String team1Name;
  final String team2Name;
  final String team1LogoUrl;
  final String team2LogoUrl;
  final VoidCallback? onBuyPressed;
  final VoidCallback? onMyTicketPressed;
  final double horizontalMargin;
  final double verticalMargin;
  final double padding;

  const TicketCard(
      {super.key,
      required this.league,
      required this.dateTime,
      required this.team1Name,
      required this.team2Name,
      required this.team1LogoUrl,
      required this.team2LogoUrl,
      this.horizontalMargin = 10,
      this.verticalMargin = 10,
      this.padding = 16,
      this.onBuyPressed,
      this.onMyTicketPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
      padding: EdgeInsets.all(padding),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Заголовок
              Text(
                league,
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
              ),
              // Дата и время
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6FF),
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: Text(
                      dateTime,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8CA4C7),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Логотипы и команды
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Team 1
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
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
                        color: Colors.black),
                  ),
                ],
              ),
              // VS
              const Text(
                "V",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF263238),
                ),
              ),
              // Team 2
              Column(
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
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
                        color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Кнопки
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: onBuyPressed,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF166CFF),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 44),
                    elevation: 0,
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.buyMore,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: onMyTicketPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF166CFF),
                    side:
                        const BorderSide(color: Color(0xFF166CFF), width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: const Size(0, 44),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.myTicket,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
