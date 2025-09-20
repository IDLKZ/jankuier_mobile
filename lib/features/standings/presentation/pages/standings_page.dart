import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/standings/domain/parameters/match_parameter.dart';
import '../../../../features/tournament/data/entities/tournament_entity.dart';

import '../../../../core/constants/hive_constants.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/di/injection.dart';
import '../../data/entities/match_entity.dart';
import '../../data/entities/score_table_team_entity.dart';
import '../bloc/standing_bloc.dart';
import '../bloc/standing_event.dart';
import '../bloc/standing_state.dart';
import '../widgets/standings_header_widget.dart';
import '../widgets/team_table_item_widget.dart';
import '../widgets/match_item_widget.dart';

class StandingsPage extends StatelessWidget {
  const StandingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<StandingBloc>(),
      child: const _StandingsPageView(),
    );
  }
}

class _StandingsPageView extends StatefulWidget {
  const _StandingsPageView();

  @override
  State<_StandingsPageView> createState() => _StandingsPageState();
}

class _StandingsPageState extends State<_StandingsPageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TournamentEntity? tournament;
  final HiveUtils _hiveUtils = getIt<HiveUtils>();
  late MatchParameter parameter;

  // PageStorage bucket для сохранения состояний вкладок
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _loadActiveData();
  }

  Future<void> _loadActiveData() async {
    // Получаем данные турнира как Map, затем создаем entity
    final tournamentJson = await _hiveUtils
        .get<Map<String, dynamic>>(HiveConstant.mainTournamentKey);
    if (tournamentJson != null) {
      tournament = TournamentEntity.fromJson(tournamentJson);
    }

    // Получаем ID активного сезона как int
    final seasonId = await _hiveUtils.get<int>(HiveConstant.activeSeasonIdKey);
    final tournamentId =
        await _hiveUtils.get<int>(HiveConstant.mainTournamentIdKey);

    parameter = MatchParameter(
      tournamentId: tournamentId ?? 0,
      seasonId: seasonId ?? 0,
    );

    if (mounted) {
      // по умолчанию загружаем таблицу
      context.read<StandingBloc>().add(LoadStandingsTableFromSotaEvent());
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    if (_tabController.index == 0) {
      context.read<StandingBloc>().add(LoadStandingsTableFromSotaEvent());
    } else {
      context.read<StandingBloc>().add(LoadMatchesFromSotaEvent(parameter));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageStorage(
      bucket: _bucket,
      child: Scaffold(
        body: Column(
          children: [
            StandingsHeaderWidget(
              tournamentName: tournament?.name,
              tournamentImage: tournament?.image,
            ),
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Таблица"),
                  Tab(text: "Результаты"),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF4B79CF),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  PageStorage(
                    bucket: _bucket,
                    child: _buildTableTab(),
                  ),
                  PageStorage(
                    bucket: _bucket,
                    child: _buildResultsTab(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableTab() {
    return BlocBuilder<StandingBloc, GetStandingState>(
      builder: (context, state) {
        if (state is GetStandingsTableFromSotaLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetStandingsTableFromSotaLoadedState) {
          return _buildStandingsTable(state.result);
        } else if (state is GetStandingsTableFromSotaFailedState) {
          return Center(
            child: Text("Ошибка загрузки: ${state.failureData.message}"),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildStandingsTable(List<ScoreTableTeamEntity> teams) {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                    width: 30.w,
                    child: Text("№",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp))),
                Expanded(
                    flex: 3,
                    child: Text("Команда",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp))),
                SizedBox(
                    width: 30.w,
                    child: Text("И",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp))),
                SizedBox(
                    width: 50.w,
                    child: Text("Г",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp))),
                SizedBox(
                    width: 30.w,
                    child: Text("О",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.sp))),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              key: const PageStorageKey('standings_table_list'),
              itemCount: teams.length,
              itemBuilder: (context, index) {
                return TeamTableItemWidget(
                  team: teams[index],
                  position: index + 1,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsTab() {
    return BlocBuilder<StandingBloc, GetStandingState>(
      builder: (context, state) {
        if (state is GetMatchesFromSotaLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMatchesFromSotaLoadedState) {
          return _buildMatchesList(state.result);
        } else if (state is GetMatchesFromSotaFailedState) {
          return Center(
            child: Text("Ошибка загрузки: ${state.failureData.message}"),
          );
        }
        return const Center(
          child: Text("Выберите вкладку 'Результаты' для загрузки матчей"),
        );
      },
    );
  }

  Widget _buildMatchesList(List<MatchEntity> matches) {
    final groupedMatches = <int, List<MatchEntity>>{};

    for (final match in matches) {
      if (!groupedMatches.containsKey(match.tour)) {
        groupedMatches[match.tour] = [];
      }
      groupedMatches[match.tour]!.add(match);
    }

    return Container(
      color: Colors.grey[50],
      child: ListView.builder(
        key: const PageStorageKey('standings_matches_list'),
        itemCount: groupedMatches.keys.length,
        itemBuilder: (context, index) {
          final tour = groupedMatches.keys.elementAt(index);
          final tourMatches = groupedMatches[tour]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                color: Colors.grey[200],
                child: Text(
                  "Тур $tour",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ...tourMatches.map((match) => MatchItemWidget(match: match)),
            ],
          );
        },
      ),
    );
  }
}
