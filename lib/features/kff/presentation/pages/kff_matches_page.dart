import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_event.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../bloc/get_all_league/get_all_league_state.dart';
import '../../data/entities/from_kff/kff_league_entity.dart';
import '../bloc/get_future_matches/get_future_matches_bloc.dart';
import '../bloc/get_future_matches/get_future_matches_event.dart';
import '../bloc/get_future_matches/get_future_matches_state.dart';
import '../bloc/get_past_matches/get_past_matches_bloc.dart';
import '../bloc/get_past_matches/get_past_matches_event.dart';
import '../bloc/get_past_matches/get_past_matches_state.dart';
import '../bloc/get_players/get_players_bloc.dart';
import '../bloc/get_players/get_players_event.dart';
import '../bloc/get_players/get_players_state.dart';
import '../bloc/get_coaches/get_coaches_bloc.dart';
import '../bloc/get_coaches/get_coaches_event.dart';
import '../bloc/get_coaches/get_coaches_state.dart';

class KffMatchesPage extends StatefulWidget {
  const KffMatchesPage({super.key});

  @override
  State<KffMatchesPage> createState() => _KffMatchesPageState();
}

class _KffMatchesPageState extends State<KffMatchesPage>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _dataTabController;
  int selectedLeagueIndex = 0;

  @override
  void initState() {
    super.initState();
    _mainTabController = TabController(length: 2, vsync: this);
    _dataTabController = TabController(length: 4, vsync: this);
    _mainTabController.addListener(_onMainTabChanged);
    _dataTabController.addListener(_onDataTabChanged);
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _dataTabController.dispose();
    super.dispose();
  }

  void _onMainTabChanged() {
    if (_mainTabController.indexIsChanging) return;
    setState(() {});
  }

  void _onDataTabChanged() {
    if (_dataTabController.indexIsChanging) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: PagesCommonAppBar(
        title: 'Матчи',
        actionIcon: Icons.sports_soccer,
        onActionTap: () {},
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        width: double.infinity,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _mainTabController.animateTo(0);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          gradient: _mainTabController.index == 0
                              ? AppColors.primaryGradient
                              : null,
                          color:
                              _mainTabController.index == 0 ? null : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Таблица',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: _mainTabController.index == 0
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
                        _mainTabController.animateTo(1);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        decoration: BoxDecoration(
                          gradient: _mainTabController.index == 1
                              ? AppColors.primaryGradient
                              : null,
                          color:
                              _mainTabController.index == 1 ? null : Colors.white,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(
                            'Результаты',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: _mainTabController.index == 1
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
            Expanded(
              child: TabBarView(
                controller: _mainTabController,
                children: [
                  BlocProvider<GetAllLeagueBloc>(
                    create: (BuildContext context) => getIt<GetAllLeagueBloc>()
                      ..add(GetAllLeagueRequestEvent()),
                    child: BlocConsumer<GetAllLeagueBloc, GetAllLeagueState>(
                      listener: (BuildContext context, state) {},
                      builder: (BuildContext context, state) {
                        if (state is GetAllLeagueLoadingState) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is GetAllLeagueSuccessState) {
                          return _buildLeaguesList(state.leagues);
                        } else if (state is GetAllLeagueFailedState) {
                          return Center(
                            child: Text(
                              'Ошибка загрузки: ${state.failure.message}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: AppColors.error,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  SingleChildScrollView(
                    child: Text("Клубы"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaguesList(List<KffLeagueEntity> leagues) {
    if (leagues.isEmpty) return const SizedBox();

    final selectedLeagueId = leagues[selectedLeagueIndex].id;

    return Column(
      children: [
        SizedBox(height: 20.h),
        // League Selection Horizontal List
        SizedBox(
          height: 50.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: leagues.length,
            itemBuilder: (context, index) {
              final league = leagues[index];
              final isSelected = selectedLeagueIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedLeagueIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 12.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : AppColors.white,
                    borderRadius: BorderRadius.circular(25.r),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.grey300,
                            width: 1.5,
                          ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: AppColors.gradientStart.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [
                            BoxShadow(
                              color: AppColors.shadow,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                  ),
                  child: Center(
                    child: Text(
                      league.title ?? 'Без названия',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                        color: isSelected ? AppColors.white : AppColors.gradientStart,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20.h),
        // Data Tabs for Selected League
        Container(
          decoration: BoxDecoration(
            color: AppColors.grey100,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TabBar(
            controller: _dataTabController,
            labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.circular(8.r),
            ),
            labelColor: AppColors.white,
            unselectedLabelColor: AppColors.textSecondary,
            labelStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: "Будущие"),
              Tab(text: "Прошлые"),
              Tab(text: "Игроки"),
              Tab(text: "Тренеры"),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        // Content for Data Tabs
        Expanded(
          child: MultiBlocProvider(
            providers: [
              BlocProvider<GetFutureMatchesBloc>(
                create: (context) => getIt<GetFutureMatchesBloc>()
                  ..add(GetFutureMatchesRequestEvent(selectedLeagueId)),
              ),
              BlocProvider<GetPastMatchesBloc>(
                create: (context) => getIt<GetPastMatchesBloc>()
                  ..add(GetPastMatchesRequestEvent(selectedLeagueId)),
              ),
              BlocProvider<GetPlayersBloc>(
                create: (context) => getIt<GetPlayersBloc>()
                  ..add(GetPlayersRequestEvent(selectedLeagueId)),
              ),
              BlocProvider<GetCoachesBloc>(
                create: (context) => getIt<GetCoachesBloc>()
                  ..add(GetCoachesRequestEvent(selectedLeagueId)),
              ),
            ],
            child: TabBarView(
              controller: _dataTabController,
              children: [
                _buildFutureMatchesTab(),
                _buildPastMatchesTab(),
                _buildPlayersTab(),
                _buildCoachesTab(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFutureMatchesTab() {
    return BlocBuilder<GetFutureMatchesBloc, GetFutureMatchesState>(
      builder: (context, state) {
        if (state is GetFutureMatchesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetFutureMatchesSuccessState) {
          return _buildMatchesList(state.matches, true);
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
    );
  }

  Widget _buildPastMatchesTab() {
    return BlocBuilder<GetPastMatchesBloc, GetPastMatchesState>(
      builder: (context, state) {
        if (state is GetPastMatchesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetPastMatchesSuccessState) {
          return _buildMatchesList(state.matches, false);
        } else if (state is GetPastMatchesFailedState) {
          return Center(
            child: Text(
              'Ошибка загрузки: ${state.failure.message}',
              style: TextStyle(fontSize: 16.sp, color: AppColors.error),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPlayersTab() {
    return BlocBuilder<GetPlayersBloc, GetPlayersState>(
      builder: (context, state) {
        if (state is GetPlayersLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetPlayersSuccessState) {
          return _buildPlayersList(state.players);
        } else if (state is GetPlayersFailedState) {
          return Center(
            child: Text(
              'Ошибка загрузки: ${state.failure.message}',
              style: TextStyle(fontSize: 16.sp, color: AppColors.error),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildCoachesTab() {
    return BlocBuilder<GetCoachesBloc, GetCoachesState>(
      builder: (context, state) {
        if (state is GetCoachesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetCoachesSuccessState) {
          return _buildCoachesList(state.coaches);
        } else if (state is GetCoachesFailedState) {
          return Center(
            child: Text(
              'Ошибка загрузки: ${state.failure.message}',
              style: TextStyle(fontSize: 16.sp, color: AppColors.error),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildMatchesList(dynamic matches, bool isFuture) {
    if (matches.isEmpty) {
      return Center(
        child: Text(
          isFuture ? 'Нет предстоящих матчей' : 'Нет прошедших матчей',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: matches.length,
      itemBuilder: (context, index) {
        final match = matches[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                Text(
                  match.championship?.title ?? 'Турнир не указан',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.network(
                              match.team1?.image?.thumb ?? '',
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey200,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Icon(Icons.sports_soccer, size: 20.sp),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            match.team1?.title ?? 'Команда 1',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: AppColors.primaryGradient,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Column(
                        children: [
                          if (isFuture) ...[
                            Text(
                              'ТУР ${match.tour}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              _formatDateTime(match.startedAt),
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ] else ...[
                            Text(
                              '${match.team1Score ?? 0} : ${match.team2Score ?? 0}',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'ТУР ${match.tour}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Image.network(
                              match.team2?.image?.thumb ?? '',
                              width: 40.w,
                              height: 40.w,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 40.w,
                                  height: 40.w,
                                  decoration: BoxDecoration(
                                    color: AppColors.grey200,
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: Icon(Icons.sports_soccer, size: 20.sp),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            match.team2?.title ?? 'Команда 2',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
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

  Widget _buildPlayersList(dynamic players) {
    if (players.isEmpty) {
      return Center(
        child: Text(
          'Нет игроков',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Image.network(
                player.image?.thumb ?? '',
                width: 50.w,
                height: 50.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Icon(Icons.person, size: 25.sp),
                  );
                },
              ),
            ),
            title: Text(
              '${player.firstName} ${player.lastName}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player.line?.title ?? 'Позиция не указана',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  player.club ?? 'Клуб не указан',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${player.games ?? 0}',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'игр',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCoachesList(dynamic coaches) {
    if (coaches.isEmpty) {
      return Center(
        child: Text(
          'Нет тренеров',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: coaches.length,
      itemBuilder: (context, index) {
        final coach = coaches[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(25.r),
              child: Image.network(
                coach.image?.thumb ?? '',
                width: 50.w,
                height: 50.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: AppColors.grey200,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                    child: Icon(Icons.person, size: 25.sp),
                  );
                },
              ),
            ),
            title: Text(
              '${coach.firstName} ${coach.lastName}',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coach.title ?? 'Должность не указана',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  coach.nationality ?? 'Национальность не указана',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            trailing: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'Тренер',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      },
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
}
