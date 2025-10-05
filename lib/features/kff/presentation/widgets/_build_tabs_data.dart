import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/get_coaches/get_coaches_bloc.dart';
import '../bloc/get_coaches/get_coaches_state.dart';
import '../bloc/get_future_matches/get_future_matches_bloc.dart';
import '../bloc/get_future_matches/get_future_matches_state.dart';
import '../bloc/get_past_matches/get_past_matches_bloc.dart';
import '../bloc/get_past_matches/get_past_matches_state.dart';
import '../bloc/get_players/get_players_bloc.dart';
import '../bloc/get_players/get_players_state.dart';
import '../helpers/group_by_gamer_line_helper.dart';

/// Строит таб с будущими матчами
/// Использует GetFutureMatchesBloc для получения данных
Widget buildFutureMatchesTab() {
  return BlocBuilder<GetFutureMatchesBloc, GetFutureMatchesState>(
    builder: (context, state) {
      if (state is GetFutureMatchesLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetFutureMatchesSuccessState) {
        return _buildMatchesList(state.matches, true, context);
      } else if (state is GetFutureMatchesFailedState) {
        return Center(
          child: Text(
            '${AppLocalizations.of(context)!.loadingError}: ${state.failure.message}',
            style: TextStyle(fontSize: 16.sp, color: AppColors.error),
          ),
        );
      }
      return const SizedBox();
    },
  );
}

/// Строит таб с прошедшими матчами
/// Использует GetPastMatchesBloc для получения данных
Widget buildPastMatchesTab() {
  return BlocBuilder<GetPastMatchesBloc, GetPastMatchesState>(
    builder: (context, state) {
      if (state is GetPastMatchesLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetPastMatchesSuccessState) {
        return _buildMatchesList(state.matches, false, context);
      } else if (state is GetPastMatchesFailedState) {
        return Center(
          child: Text(
            '${AppLocalizations.of(context)!.loadingError}: ${state.failure.message}',
            style: TextStyle(fontSize: 16.sp, color: AppColors.error),
          ),
        );
      }
      return const SizedBox();
    },
  );
}

/// Строит список матчей с карточками
/// Параметры:
/// [matches] - список матчей для отображения
/// [isFuture] - флаг определяющий тип матчей (будущие/прошедшие)
Widget _buildMatchesList(dynamic matches, bool isFuture, BuildContext context) {
  if (matches.isEmpty) {
    return _buildEmptyContentState(
      isFuture
          ? AppLocalizations.of(context)!.noUpcomingMatches
          : AppLocalizations.of(context)!.noPastMatches,
      isFuture ? Icons.schedule : Icons.history,
    );
  }

  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    itemCount: matches.length,
    itemBuilder: (context, index) {
      final match = matches[index];
      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
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
                  match.championship?.title ??
                      AppLocalizations.of(context)!.tournamentNotSpecified,
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
                          width: 40.w,
                          height: 40.w,
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
                        SizedBox(height: 8.h),
                        AutoSizeText(
                          match.team1?.title ??
                              AppLocalizations.of(context)!.team1,
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

                  // Center Section (Score/Time)
                  SizedBox(
                    width: 100.w,
                    child: Column(
                      children: [
                        if (isFuture) ...[
                          Column(
                            children: [
                              Text(
                                formatDateTime(match.startedAt),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ] else ...[
                          Text(
                            '${match.team1Score ?? 0} - ${match.team2Score ?? 0}',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                        SizedBox(height: 8.h),
                        match.tour != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.grey100,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  '${AppLocalizations.of(context)!.tour} ${match.tour}',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    color: AppColors.textSecondary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              )
                            : const SizedBox(),
                      ],
                    ),
                  ),

                  // Team 2
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 40.w,
                          height: 40.w,
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
                        SizedBox(height: 8.h),
                        AutoSizeText(
                          match.team2?.title ??
                              AppLocalizations.of(context)!.team2,
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
            ],
          ),
        ),
      );
    },
  );
}

/// Строит список игроков с подробной информацией, сгруппированный по позициям
/// Параметр [players] - список игроков для отображения
/// Показывает игроков по группам (позициям) с фото, клубом, статистикой
Widget _buildPlayersList(dynamic players, BuildContext context) {
  if (players.isEmpty) {
    return _buildEmptyContentState(
        AppLocalizations.of(context)!.noPlayers, Icons.people);
  }

  final groupedPlayers = groupByLineTitle(players);

  return Column(
    children: [
      // Заголовок таблицы
      Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                AppLocalizations.of(context)!.fullName,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.club,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                AppLocalizations.of(context)!.games,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: Colors.grey[700],
                ),
              ),
            ),
          ],
        ),
      ),

      // Список игроков по группам
      Expanded(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          itemCount: groupedPlayers.keys.length,
          itemBuilder: (context, index) {
            final positionName = groupedPlayers.keys.elementAt(index);
            final positionPlayers = groupedPlayers[positionName]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Заголовок позиции
                Container(
                  margin: EdgeInsets.only(top: 16.h, bottom: 8.h),
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(8.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Icon(
                        getPositionIcon(positionName),
                        size: 16.sp,
                        color: AppColors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        positionName,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '${positionPlayers.length}',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Список игроков в этой позиции
                ...positionPlayers
                    .map((player) => Container(
                          margin: EdgeInsets.only(bottom: 8.h),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8.r),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow.withValues(alpha: 0.08),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Row(
                              children: [
                                // Фото игрока (если есть)
                                Container(
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey50,
                                    borderRadius: BorderRadius.circular(20.r),
                                    border: Border.all(
                                      color: AppColors.grey200,
                                      width: 1,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(19.r),
                                    child: player.image?.avatar != null
                                        ? Image.network(
                                            player.image!.avatar!,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Icon(
                                                Icons.person,
                                                size: 20.sp,
                                                color: AppColors.textSecondary,
                                              );
                                            },
                                          )
                                        : Icon(
                                            Icons.person,
                                            size: 20.sp,
                                            color: AppColors.textSecondary,
                                          ),
                                  ),
                                ),

                                SizedBox(width: 12.w),

                                // ФИО игрока
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${player.firstName ?? ''} ${player.lastName != null ? firstLetterCapitalized(player.lastName!) : ''}'
                                            .trim(),
                                        style: TextStyle(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (player.no != null) ...[
                                        SizedBox(height: 2.h),
                                        Text(
                                          '№${player.no}',
                                          style: TextStyle(
                                            fontSize: 11.sp,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),

                                // Клуб
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    player.club ??
                                        AppLocalizations.of(context)!
                                            .clubNotSpecified,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 11.sp,
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                // Статистика игр
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '${player.games ?? 0}',
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ],
            );
          },
        ),
      ),
    ],
  );
}

/// Строит таб с игроками лиги
/// Использует GetPlayersBloc для получения данных
Widget buildPlayersTab() {
  return BlocBuilder<GetPlayersBloc, GetPlayersState>(
    builder: (context, state) {
      if (state is GetPlayersLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetPlayersSuccessState) {
        return _buildPlayersList(state.players, context);
      } else if (state is GetPlayersFailedState) {
        return Center(
          child: Text(
            '${AppLocalizations.of(context)!.loadingError}: ${state.failure.message}',
            style: TextStyle(fontSize: 16.sp, color: AppColors.error),
          ),
        );
      }
      return const SizedBox();
    },
  );
}

/// Строит таб с тренерами лиги
/// Использует GetCoachesBloc для получения данных
Widget buildCoachesTab() {
  return BlocBuilder<GetCoachesBloc, GetCoachesState>(
    builder: (context, state) {
      if (state is GetCoachesLoadingState) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetCoachesSuccessState) {
        return _buildCoachesList(state.coaches, context);
      } else if (state is GetCoachesFailedState) {
        return Center(
          child: Text(
            '${AppLocalizations.of(context)!.loadingError}: ${state.failure.message}',
            style: TextStyle(fontSize: 16.sp, color: AppColors.error),
          ),
        );
      }
      return const SizedBox();
    },
  );
}

/// Строит список тренеров с информацией о них
/// Параметр [coaches] - список тренеров для отображения
/// Показывает фото, должность, национальность тренеров
Widget _buildCoachesList(dynamic coaches, BuildContext context) {
  if (coaches.isEmpty) {
    return _buildEmptyContentState(
        AppLocalizations.of(context)!.noCoaches, Icons.sports);
  }

  return ListView.builder(
    padding: EdgeInsets.symmetric(horizontal: 4.w),
    itemCount: coaches.length,
    itemBuilder: (context, index) {
      final coach = coaches[index];
      return Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadow.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(8.w),
          child: Row(
            children: [
              // Coach Avatar with Special Border
              Container(
                width: 30.w,
                height: 30.w,
                decoration: BoxDecoration(
                  color: AppColors.grey50,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(
                    color: AppColors.grey200,
                    width: 1,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.r),
                    child: Image.network(
                      coach.image?.avatar ?? '',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: AppColors.grey50,
                            borderRadius: BorderRadius.circular(32.r),
                          ),
                          child: Icon(
                            Icons.sports,
                            size: 35.sp,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(width: 8.w),

              // Coach Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name with Coach Icon
                  Text(
                    '${coach.firstName ?? ''} ${coach.lastName ?? ''}'.trim(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  SizedBox(height: 2.h),

                  // Position/Title
                  Text(
                    coach.title ??
                        AppLocalizations.of(context)!.positionNotSpecified,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: AppColors.warning,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  // License if available
                  if (coach.license?.isNotEmpty == true) ...[
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Icon(
                          Icons.verified,
                          size: 14.sp,
                          color: AppColors.success,
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            coach.license,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: AppColors.success,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
              const Spacer(),
              Text(
                coach.nationality ??
                    AppLocalizations.of(context)!.nationalityNotSpecified,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      );
    },
  );
}

/// Строит состояние пустого контента с сообщением
/// Параметры:
/// [message] - текст сообщения
/// [icon] - иконка для отображения
Widget _buildEmptyContentState(String message, IconData icon) {
  return Container(
    padding: EdgeInsets.all(40.w),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: const BoxDecoration(
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
