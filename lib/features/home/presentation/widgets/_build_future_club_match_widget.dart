import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/matches/matches_bloc.dart';
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/matches/matches_state.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../kff_league/presentation/widgets/match_card_widget.dart';

Widget buildFutureClubMatch(BuildContext context) {
  bool isFuture = true;
  return Container(
    margin: EdgeInsets.only(top: 20.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Клубные игры',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              GestureDetector(
                onTap: () {
                  context.push(AppRouteConstants.KffLeagueClubPagePath);
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
        BlocBuilder<MatchesBloc, MatchesState>(
          builder: (context, state) {
            if (state is MatchesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MatchesError) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: AppColors.error,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        'Ошибка загрузки матчей',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.message,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is MatchesLoaded || state is MatchesLoadingMore) {
              final matches = state is MatchesLoaded
                  ? state.matches.data
                  : (state as MatchesLoadingMore).currentMatches.data;

              final hasNext = state is MatchesLoaded
                  ? state.matches.meta?.hasNext ?? false
                  : (state as MatchesLoadingMore)
                          .currentMatches
                          .meta
                          ?.hasNext ??
                      false;

              final isLoadingMore = state is MatchesLoadingMore;

              if (matches.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isFuture ? Icons.schedule : Icons.history,
                          size: 48.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          isFuture
                              ? 'Нет предстоящих матчей'
                              : 'Нет прошедших матчей',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Матчи будут отображены, когда станут доступны',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    ...matches.map((match) {
                      return MatchCardWidget(
                        match: match,
                        isFuture: isFuture,
                      );
                    }).toList(),
                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
        SizedBox(height: 16.h),
      ],
    ),
  );
}
