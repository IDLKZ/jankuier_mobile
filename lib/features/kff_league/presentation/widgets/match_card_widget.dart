import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/localization_helper.dart';
import 'match_details_bottom_sheet.dart';

class MatchCardWidget extends StatelessWidget {
  final KffLeagueClubMatchEntity match;
  final bool isFuture;

  const MatchCardWidget({
    super.key,
    required this.match,
    required this.isFuture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showMatchDetails(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            // Tournament info header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
              ),
              child: Row(
                children: [
                  if (match.tournament?.logo != null)
                    Container(
                      width: 20.w,
                      height: 20.w,
                      margin: EdgeInsets.only(right: 8.w),
                      child: ClipOval(
                        child: Image.network(
                          match.tournament!.logo!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.sports_soccer,
                              size: 16.sp,
                              color: AppColors.primary,
                            );
                          },
                        ),
                      ),
                    ),
                  Expanded(
                    child: Text(
                      () {
                        final title = context.localizedTitle(match.tournament?.title);
                        return title.isNotEmpty ? title : AppLocalizations.of(context)!.tournament;
                      }(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  if (match.stage != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        context.localizedTitle(match.stage!.title),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  // Main match info
                  Row(
                    children: [
                      // Team 1
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(25.r),
                                border: Border.all(
                                  color: AppColors.grey200,
                                  width: 1,
                                ),
                              ),
                              child: ClipOval(
                                child: match.team1?.logo != null
                                    ? Image.network(
                                        match.team1!.logo!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.sports_soccer,
                                            size: 24.sp,
                                            color: AppColors.textSecondary,
                                          );
                                        },
                                      )
                                    : Icon(
                                        Icons.sports_soccer,
                                        size: 24.sp,
                                        color: AppColors.textSecondary,
                                      ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                               () {
                                  final title = context.localizedTitle(match.team1?.title);
                                  return title.isNotEmpty ? title : AppLocalizations.of(context)!.team1;
                                }(),
                              style: TextStyle(
                                fontSize: 12.sp,
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

                      // Center section (time/score)
                      Expanded(
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
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.schedule,
                                      color: AppColors.white,
                                      size: 18.sp,
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      _formatMatchTime(
                                          match.datetimeIso, context),
                                      style: TextStyle(
                                        fontSize: 11.sp,
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
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Text(
                                  '${match.result1 ?? 0} : ${match.result2 ?? 0}',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    color: AppColors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Team 2
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: AppColors.grey50,
                                borderRadius: BorderRadius.circular(25.r),
                                border: Border.all(
                                  color: AppColors.grey200,
                                  width: 1,
                                ),
                              ),
                              child: ClipOval(
                                child: match.team2?.logo != null
                                    ? Image.network(
                                        match.team2!.logo!,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.sports_soccer,
                                            size: 24.sp,
                                            color: AppColors.textSecondary,
                                          );
                                        },
                                      )
                                    : Icon(
                                        Icons.sports_soccer,
                                        size: 24.sp,
                                        color: AppColors.textSecondary,
                                      ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                             () {
                                final title = context.localizedTitle(match.team2?.title);
                                return title.isNotEmpty ? title : AppLocalizations.of(context)!.team2;
                              }(),
                              style: TextStyle(
                                fontSize: 12.sp,
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

                  SizedBox(height: 16.h),

                  // Stadium and date info
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.grey50,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.stadium,
                          size: 16.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                                () {
                              final title = context.localizedTitle(match.stadiumObj?.title);
                              return title.isNotEmpty ? title : AppLocalizations.of(context)!.stadiumNotSpecified;
                            }(),
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          _formatMatchDate(match.datetimeIso, context),
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Additional info for past matches
                  if (!isFuture &&
                      (match.attendance != null || match.protocol != null)) ...[
                    SizedBox(height: 12.h),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Column(
                        children: [
                          if (match.attendance != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  size: 16.sp,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  '${AppLocalizations.of(context)!.attendance}: ${match.attendance}',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                          if (match.attendance != null &&
                              match.protocol != null)
                            SizedBox(height: 8.h),
                          if (match.protocol != null) ...[
                            Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 16.sp,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    AppLocalizations.of(context)!.matchProtocol,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.open_in_new,
                                  size: 14.sp,
                                  color: AppColors.primary,
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMatchDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MatchDetailsBottomSheet(
        match: match,
        isFuture: isFuture,
      ),
    );
  }

  String _formatMatchTime(String? dateTimeIso, BuildContext context) {
    if (dateTimeIso == null || dateTimeIso.isEmpty) {
      return AppLocalizations.of(context)!.timeNotSpecified;
    }

    try {
      final dateTime = DateTime.parse(dateTimeIso);
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');

      return '$hour:$minute\n$day.$month';
    } catch (e) {
      return AppLocalizations.of(context)!.timeNotSpecified;
    }
  }

  String _formatMatchDate(String? dateTimeIso, BuildContext context) {
    if (dateTimeIso == null || dateTimeIso.isEmpty) {
      return AppLocalizations.of(context)!.dateNotSpecified;
    }

    try {
      final dateTime = DateTime.parse(dateTimeIso);
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year;
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');

      return '$day.$month.$year $hour:$minute';
    } catch (e) {
      return AppLocalizations.of(context)!.dateNotSpecified;
    }
  }
}
