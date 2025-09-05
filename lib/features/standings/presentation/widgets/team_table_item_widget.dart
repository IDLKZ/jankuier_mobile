import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: Colors.white,
      child: Row(
        children: [
          SizedBox(
            width: 30.w,
            child: Text(
              "$position",
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4.r),
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
                          size: 16.w,
                          color: Colors.grey[800],
                        )
                      : null,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    team.name,
                    style: TextStyle(fontSize: 14.sp, color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30.w,
            child: Text(
              "${team.matches}",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          SizedBox(
            width: 50.w,
            child: Text(
              team.goals,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp),
            ),
          ),
          SizedBox(
            width: 30.w,
            child: Text(
              "${team.points}",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
