import 'package:flutter/cupertino.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
import '../../../standings/data/entities/match_entity.dart';
import '../../../standings/data/entities/score_table_team_entity.dart';
import '../../../standings/presentation/bloc/standing_bloc.dart';
import '../../../standings/presentation/bloc/standing_state.dart';
import '../../../standings/presentation/widgets/team_table_item_widget.dart';
import 'home_helpers.dart';

Widget buildTabsSectionWithScroll(
    BuildContext context, TabController tabController, VoidCallback onRefresh) {
  return Column(
    children: [
      // Tab bar
      Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  tabController.animateTo(0);
                  onRefresh;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: tabController.index == 0
                        ? AppColors.primaryGradient
                        : null,
                    color: tabController.index == 0 ? null : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.table,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: tabController.index == 0
                            ? Colors.white
                            : AppColors.gradientStart,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.w),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  tabController.animateTo(1);
                  onRefresh;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: tabController.index == 1
                        ? AppColors.primaryGradient
                        : null,
                    color: tabController.index == 1 ? null : Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.results,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: tabController.index == 1
                            ? Colors.white
                            : AppColors.gradientStart,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 10.h),
      // Tab content without Expanded - let content take natural height
      tabController.index == 0
          ? _buildTableTabWithoutExpanded()
          : _buildResultsTabWithoutExpanded(),
    ],
  );
}

Widget _buildTableTabWithoutExpanded() {
  return BlocBuilder<StandingBloc, GetStandingState>(
    builder: (context, state) {
      if (state is GetStandingsTableFromSotaLoadingState) {
        return Container(
          height: 200.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (state is GetStandingsTableFromSotaLoadedState) {
        return _buildStandingsTableWithoutExpanded(state.result, context);
      } else if (state is GetStandingsTableFromSotaFailedState) {
        return Container(
          height: 200.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: Colors.red[300],
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.tableLoadError,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.failureData.message ??
                      AppLocalizations.of(context)!.unknownError,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }
      return const SizedBox();
    },
  );
}

Widget _buildResultsTabWithoutExpanded() {
  return BlocBuilder<StandingBloc, GetStandingState>(
    builder: (context, state) {
      if (state is GetMatchesFromSotaLoadingState ||
          state is GetStandingsTableFromSotaLoadingState) {
        return SizedBox(
          height: 200.h,
          child: const Center(child: CircularProgressIndicator()),
        );
      } else if (state is GetStandingsAndMatchesLoadedState) {
        // Комбинированный state с таблицей и матчами
        return _buildMatchesListWithoutExpanded(
            state.matches, context, state.standings);
      } else if (state is GetMatchesFromSotaLoadedState) {
        // Только матчи (без таблицы) - показываем без логотипов
        // Bloc автоматически загрузит таблицу при следующем запросе
        return _buildMatchesListWithoutExpanded(state.result, context, null);
      } else if (state is GetMatchesFromSotaFailedState) {
        return SizedBox(
          height: 200.h,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 48.sp,
                  color: Colors.red[300],
                ),
                SizedBox(height: 16.h),
                Text(
                  AppLocalizations.of(context)!.matchesLoadError,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.failureData.message ??
                      AppLocalizations.of(context)!.unknownError,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      }
      return SizedBox(
        height: 100.h,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

Widget _buildStandingsTableWithoutExpanded(
    List<ScoreTableTeamEntity> teams, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.w),
    decoration: BoxDecoration(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        // Header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
                child: Text(
                  AppLocalizations.of(context)!.position,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.team,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(
                width: 30.w,
                child: Text(
                  AppLocalizations.of(context)!.matchesPlayed,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(
                width: 50.w,
                child: Text(
                  AppLocalizations.of(context)!.goalsScored,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
              SizedBox(
                width: 20.w,
                child: Text(
                  AppLocalizations.of(context)!.points,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Teams list - without Expanded, let content take natural height
        ...teams.asMap().entries.map((entry) {
          int index = entry.key;
          ScoreTableTeamEntity team = entry.value;
          return TeamTableItemWidget(
            team: team,
            position: index + 1,
          );
        }).toList(),
      ],
    ),
  );
}

Widget _buildMatchesListWithoutExpanded(List<MatchEntity> matches,
    BuildContext context, List<ScoreTableTeamEntity>? standings) {
  final groupedMatches = <int, List<MatchEntity>>{};

  for (final match in matches) {
    if (!groupedMatches.containsKey(match.tour)) {
      groupedMatches[match.tour] = [];
    }
    groupedMatches[match.tour]!.add(match);
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.w),
    color: AppColors.background,
    child: Column(
      children: groupedMatches.keys.map((tour) {
        final tourMatches = groupedMatches[tour]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tour header
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                "${AppLocalizations.of(context)!.round} $tour",
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            // Matches for this tour
            ...tourMatches.map((match) =>
                _buildMatchCardWithoutMargin(match, context, standings)),
            SizedBox(height: 16.h),
          ],
        );
      }).toList(),
    ),
  );
}

Widget _buildMatchCardWithoutMargin(MatchEntity match, BuildContext context,
    List<ScoreTableTeamEntity>? standings) {
  // Получаем логотипы из таблицы, если она доступна
  final homeTeamLogo =
      standings != null ? getTeamLogoById(match.homeTeam.id, standings) : '';
  final awayTeamLogo =
      standings != null ? getTeamLogoById(match.awayTeam.id, standings) : '';

  return GestureDetector(
    onTap: () {
      context.push(
        '${AppRouteConstants.GameStatPagePath}${match.id}',
        extra: {
          'match': match,
          'standings': standings,
        },
      );
    },
    child: Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Home team
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // Home team logo
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    image: homeTeamLogo.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(homeTeamLogo),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: homeTeamLogo.isEmpty
                      ? Icon(
                          Icons.sports_soccer,
                          color: Colors.grey,
                          size: 24.sp,
                        )
                      : null,
                ),
                SizedBox(height: 8.h),
                // Home team name
                Text(
                  match.homeTeam.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Score and match info
          Expanded(
            flex: 1,
            child: Column(
              children: [
                // Score
                Text(
                  "${match.homeTeam.score ?? 0} - ${match.awayTeam.score ?? 0}",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 4.h),
                // Date and time
                Text(
                  formatDate(match.date),
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Away team
          Expanded(
            flex: 2,
            child: Column(
              children: [
                // Away team logo
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    shape: BoxShape.circle,
                    image: awayTeamLogo.isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(awayTeamLogo),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: awayTeamLogo.isEmpty
                      ? Icon(
                          Icons.sports_soccer,
                          color: Colors.grey,
                          size: 24.sp,
                        )
                      : null,
                ),
                SizedBox(height: 8.h),
                // Away team name
                Text(
                  match.awayTeam.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
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
    ),
  );
}
