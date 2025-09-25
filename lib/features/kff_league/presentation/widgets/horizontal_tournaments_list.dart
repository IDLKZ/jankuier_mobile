import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/core/constants/app_colors.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_tournament_entity.dart';

import '../../../../l10n/app_localizations.dart';

class HorizontalTournamentsList extends StatelessWidget {
  final List<KffLeagueTournamentWithSeasonsEntity> tournaments;
  final Function(KffLeagueTournamentSeasonEntity)? onTournamentTap;
  final int? selectedTournamentId;

  const HorizontalTournamentsList({
    super.key,
    required this.tournaments,
    this.onTournamentTap,
    this.selectedTournamentId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16.h),
      child: SizedBox(
        height: 150.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemCount: tournaments.length,
          itemBuilder: (context, index) {
            final tournament = tournaments[index];
            final firstSeason = tournament.seasons?.isNotEmpty == true
                ? tournament.seasons!.first
                : null;

            if (firstSeason == null) return const SizedBox();

            final isSelected = selectedTournamentId == firstSeason.tournamentId;

            return GestureDetector(
              onTap: () => onTournamentTap?.call(firstSeason),
              child: Container(
                width: 100.w,
                margin: EdgeInsets.only(right: 16.w),
                child: Column(
                  children: [
                    // Tournament Logo Circle
                    Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.grey200,
                          width: isSelected ? 2.5 : 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.shadow.withValues(alpha: 0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: firstSeason.logo != null &&
                                firstSeason.logo!.isNotEmpty
                            ? Image.network(
                                firstSeason.logo!,
                                fit: BoxFit.fitHeight,
                                errorBuilder: (context, error, stackTrace) {
                                  return _buildFallbackIcon();
                                },
                              )
                            : _buildFallbackIcon(),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Tournament Title
                    AutoSizeText(
                      firstSeason.title?.ru ??
                          AppLocalizations.of(context)!.tournament,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.textPrimary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.clip,
                    ),

                    SizedBox(height: 2.h),

                    // Season Title
                    AutoSizeText(
                      firstSeason.season?.title ?? '',
                      style: TextStyle(
                        fontSize: 9.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textSecondary,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFallbackIcon() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withValues(alpha: 0.1),
            AppColors.gradientEnd.withValues(alpha: 0.1),
          ],
        ),
      ),
      child: Icon(
        Icons.sports_soccer,
        size: 24.sp,
        color: AppColors.primary,
      ),
    );
  }
}
