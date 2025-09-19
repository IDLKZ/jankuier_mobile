import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/entities/score_table_team_entity.dart';

class TeamTableItemWidget extends StatelessWidget {
  final ScoreTableTeamEntity team;
  final int position;

  const TeamTableItemWidget({
    super.key,
    required this.team,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    // Определяем цвет позиции в зависимости от места в таблице
    Color positionColor = AppColors.textSecondary;
    Color positionBgColor = AppColors.grey100;

    if (position <= 3) {
      // Топ 3 - градиент
      positionBgColor = AppColors.gradientStart;
      positionColor = Colors.white;
    } else if (position <= 6) {
      // Европейские кубки
      positionBgColor = AppColors.info;
      positionColor = Colors.white;
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Позиция в таблице
          Container(
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: positionBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                "$position",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w700,
                  color: positionColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),

          // Логотип и название команды
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 20.w,
                  height: 20.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8),
                    image: team.logo.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(team.logo),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: team.logo.isEmpty
                      ? Icon(
                          Icons.sports_soccer,
                          size: 20.w,
                          color: Colors.grey[600],
                        )
                      : null,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    team.name,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // Статистика в ряд
          Row(
            children: [
              SizedBox(
                width: 30.w,
                child: _buildStatItem("И", "${team.matches}", AppColors.textSecondary),
              ),
              SizedBox(
                width: 40.w,
                child: _buildStatItem("Г", team.goals, AppColors.textSecondary),
              ),
              SizedBox(
                width: 30.w,
                child: _buildStatItem("О", "${team.points}", AppColors.gradientStart),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color valueColor) {
    return Text(
      value,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: valueColor,
      ),
      textAlign: TextAlign.center,
    );
  }
}
