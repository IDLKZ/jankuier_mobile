import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../tournament/data/entities/tournament_entity.dart';
import '_build_league_carousel.dart';

Widget buildMainTournamentCard(TournamentEntity? selectedTournament) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
    padding: EdgeInsets.all(20.w),
    decoration: BoxDecoration(
      gradient: AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 60.w,
          height: 60.h,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: selectedTournament?.image != null
              ? ClipOval(
            child: buildTournamentImage(selectedTournament!.image!),
          )
              : Icon(
            Icons.sports_soccer,
            color: Colors.grey,
            size: 30.sp,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              selectedTournament?.name != null
                  ? Text(
                selectedTournament!.name,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              )
                  : Text(
                'ПРЕМЬЕР ЛИГА',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              Text(
                'Казахстана',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}