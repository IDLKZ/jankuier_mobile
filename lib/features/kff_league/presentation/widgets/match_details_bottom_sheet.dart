import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/core/utils/localization_helper.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../l10n/app_localizations.dart';

class MatchDetailsBottomSheet extends StatelessWidget {
  final KffLeagueClubMatchEntity match;
  final bool isFuture;

  const MatchDetailsBottomSheet({
    super.key,
    required this.match,
    required this.isFuture,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.symmetric(vertical: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.grey300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tournament header
                  _buildTournamentHeader(context),

                  SizedBox(height: 20.h),

                  // Main match info
                  _buildMainMatchInfo(context),

                  SizedBox(height: 24.h),

                  // Match details
                  _buildMatchDetails(context),

                  if (!isFuture) ...[
                    SizedBox(height: 24.h),
                    _buildPastMatchExtras(context),
                  ],

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTournamentHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          if (match.tournament?.logo != null)
            Container(
              width: 32.w,
              height: 32.w,
              margin: EdgeInsets.only(right: 12.w),
              child: ClipOval(
                child: Image.network(
                  match.tournament!.logo!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.sports_soccer,
                      size: 20.sp,
                      color: AppColors.white,
                    );
                  },
                ),
              ),
            ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                 () {
                    final title = context.localizedTitle(match.tournament?.title);
                    return title.isNotEmpty ? title : AppLocalizations.of(context)!.tournament;
                  }(),
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                if (match.stage != null)
                  Text(
                    () {
                      final title = context.localizedTitle(match.stage?.title);
                      return title.isNotEmpty ? title : '';
                    }(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.white.withValues(alpha: 0.8),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainMatchInfo(BuildContext context) {
    return Row(
      children: [
        // Team 1
        Expanded(
          child: Column(
            children: [
              Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(40.r),
                  border: Border.all(
                    color: AppColors.grey200,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: match.team1?.logo != null
                      ? Image.network(
                          match.team1!.logo!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.sports_soccer,
                              size: 32.sp,
                              color: AppColors.textSecondary,
                            );
                          },
                        )
                      : Icon(
                          Icons.sports_soccer,
                          size: 32.sp,
                          color: AppColors.textSecondary,
                        ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                () {
                  final title = context.localizedTitle(match.team1?.title);
                  return title.isNotEmpty ? title : AppLocalizations.of(context)!.team1;
                }(),
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

        // Center section (time/score)
        Expanded(
          child: Column(
            children: [
              if (isFuture) ...[
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 16.h,
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
                        size: 24.sp,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        _formatMatchTime(match.datetimeIso, context),
                        style: TextStyle(
                          fontSize: 13.sp,
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
                    horizontal: 24.w,
                    vertical: 20.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: AutoSizeText(
                    '${match.result1 ?? 0} : ${match.result2 ?? 0}',
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
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
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(40.r),
                  border: Border.all(
                    color: AppColors.grey200,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: match.team2?.logo != null
                      ? Image.network(
                          match.team2!.logo!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.sports_soccer,
                              size: 32.sp,
                              color: AppColors.textSecondary,
                            );
                          },
                        )
                      : Icon(
                          Icons.sports_soccer,
                          size: 32.sp,
                          color: AppColors.textSecondary,
                        ),
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                () {
                  final title = context.localizedTitle(match.team2?.title);
                  return title.isNotEmpty ? title : AppLocalizations.of(context)!.team2;
                }(),
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
    );
  }

  Widget _buildMatchDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.team2,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),

        // Stadium with photo
        _buildStadiumSection(context),

        // Date and time
        _buildDetailItem(
          icon: Icons.schedule,
          title: AppLocalizations.of(context)!.dateAndTime,
          value: _formatFullDateTime(match.datetimeIso, context),
        ),

        // Status
        if (match.status != null)
          _buildDetailItem(
            icon: Icons.info_outline,
            title: AppLocalizations.of(context)!.status,
            value: _getStatusText(match.status!, context),
          ),
      ],
    );
  }

  Widget _buildPastMatchExtras(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.additionalInfo,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 16.h),
        if (match.attendance != null)
          _buildDetailItem(
            icon: Icons.people,
            title: AppLocalizations.of(context)!.attendanceCount,
            value: '${match.attendance}',
          ),
        if (match.protocol != null)
          _buildDetailItem(
            icon: Icons.description,
            title: AppLocalizations.of(context)!.matchProtocol,
            value: AppLocalizations.of(context)!.downloadPdf,
            isClickable: true,
            onTap: () => _launchUrl(match.protocol!),
          ),
        if (match.reviewCode != null && match.reviewCode!.isNotEmpty)
          _buildDetailItem(
            icon: Icons.video_library,
            title: AppLocalizations.of(context)!.videoOverview,
            value: AppLocalizations.of(context)!.watchOnYoutube,
            isClickable: true,
            onTap: () => _showVideoReview(),
          ),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String title,
    required String value,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12.r),
        border: isClickable
            ? Border.all(color: AppColors.primary.withValues(alpha: 0.3))
            : null,
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isClickable ? AppColors.primary : AppColors.textSecondary,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isClickable
                          ? AppColors.primary
                          : AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            if (isClickable)
              Icon(
                Icons.arrow_forward_ios,
                size: 16.sp,
                color: AppColors.primary,
              ),
          ],
        ),
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

  String _formatFullDateTime(String? dateTimeIso, BuildContext context) {
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

      return '$day.$month.$year в $hour:$minute';
    } catch (e) {
      return AppLocalizations.of(context)!.invalidDateFormat;
    }
  }

  String _getStatusText(int status, BuildContext context) {
    switch (status) {
      case 1:
        return AppLocalizations.of(context)!.scheduled;
      case 2:
        return AppLocalizations.of(context)!.finished;
      case 3:
        return AppLocalizations.of(context)!.canceled;
      default:
        return AppLocalizations.of(context)!.unknown;
    }
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _showVideoReview() {
    // Here we could implement a YouTube player or open in browser
    // For now, just extract the video ID and open in browser
    if (match.reviewCode != null) {
      final videoId = _extractYouTubeVideoId(match.reviewCode!);
      if (videoId != null) {
        _launchUrl('https://www.youtube.com/watch?v=$videoId');
      }
    }
  }

  String? _extractYouTubeVideoId(String iframeCode) {
    final regex = RegExp(r'embed\/([a-zA-Z0-9_-]+)');
    final match = regex.firstMatch(iframeCode);
    return match?.group(1);
  }

  Widget _buildStadiumSection(BuildContext context) {
    final stadium = match.stadiumObj;
    if (stadium == null) {
      return _buildDetailItem(
        icon: Icons.stadium,
        title: AppLocalizations.of(context)!.stadium,
        value: AppLocalizations.of(context)!.stadiumNameNotSpecified,
      );
    }

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.grey50,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stadium photo
          if (stadium.photo != null && stadium.photo!.isNotEmpty) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: Image.network(
                stadium.photo!,
                width: double.infinity,
                height: 120.h,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.stadium,
                      size: 48.sp,
                      color: AppColors.textSecondary,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 12.h),
          ],

          // Stadium info
          Row(
            children: [
              Icon(
                Icons.stadium,
                size: 20.sp,
                color: AppColors.textSecondary,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.stadium,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      () {
                        final title = context.localizedTitle(stadium.title);
                        return title.isNotEmpty ? title : AppLocalizations.of(context)!.notSpecified;
                      }(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
