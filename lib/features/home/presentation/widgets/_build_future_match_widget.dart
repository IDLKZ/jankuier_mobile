import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart';
import '../../../kff/presentation/bloc/get_future_matches/get_future_matches_state.dart';

Widget buildFutureMatch(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Игры сборной',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            GestureDetector(
              onTap: () {
                context.push(AppRouteConstants.KffMatchesPagePath);
              },
              child: Text(
                'Все игры',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.gradientStart,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16.h),
      BlocBuilder<GetFutureMatchesBloc, GetFutureMatchesState>(
        builder: (context, state) {
          if (state is GetFutureMatchesLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetFutureMatchesSuccessState) {
            return homebuildMatchesList(state.matches, true);
          } else if (state is GetFutureMatchesFailedState) {
            return Center(
              child: Text(
                'Ошибка загрузки: ${state.failure.message}',
                style: TextStyle(fontSize: 16.sp, color: AppColors.error),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      SizedBox(height: 16.h),
    ],
  );
}

Widget homebuildMatchesList(dynamic matches, bool isFuture) {
  if (matches.isEmpty) {
    return homebuildEmptyContentState(
      isFuture ? 'Нет предстоящих матчей' : 'Нет прошедших матчей',
      isFuture ? Icons.schedule : Icons.history,
    );
  }
  return Column(
    children: matches.map<Widget>((match) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Championship Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  match.championship?.title ?? 'Турнир не указан',
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20.h),

              // Teams and Score/Time
              Row(
                children: [
                  // Team 1
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: AppColors.grey200,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28.r),
                            child: Image.network(
                              match.team1?.image?.avatar ?? '',
                              fit: BoxFit.fitHeight,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.sports_soccer,
                                  size: 30.sp,
                                  color: AppColors.textSecondary,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          match.team1?.title ?? 'Команда 1',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  // Center Section (Score/Time)
                  SizedBox(
                    width: 120.w,
                    child: Column(
                      children: [
                        if (isFuture) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(16.r),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  color: AppColors.white,
                                  size: 20.sp,
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  _formatDateTime(match.startedAt),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ] else ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 16.h,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              '${match.team1Score ?? 0} : ${match.team2Score ?? 0}',
                              style: TextStyle(
                                fontSize: 24.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                        SizedBox(height: 8.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grey100,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            'ТУР ${match.tour}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Team 2
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60.w,
                          height: 60.w,
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: AppColors.grey200,
                              width: 2,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(28.r),
                            child: Image.network(
                              match.team2?.image?.avatar ?? '',
                              fit: BoxFit.fitHeight,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.sports_soccer,
                                  size: 30.sp,
                                  color: AppColors.textSecondary,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          match.team2?.title ?? 'Команда 2',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget homebuildEmptyContentState(String message, IconData icon) {
  return Container(
    padding: EdgeInsets.all(40.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: AppColors.grey100,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            size: 40.sp,
            color: AppColors.textSecondary,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          message,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

String _formatDateTime(String? dateTime) {
  if (dateTime == null) return 'Время не указано';
  try {
    final dt = DateTime.parse(dateTime);
    return '${dt.day}.${dt.month.toString().padLeft(2, '0')}.${dt.year}\n${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  } catch (e) {
    return 'Неверный формат';
  }
}
