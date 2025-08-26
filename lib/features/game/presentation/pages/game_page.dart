import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/standings/data/entities/match_entity.dart';

import '../../../../core/di/injection.dart';
import '../../data/entities/match_lineup_entity.dart';
import '../../data/entities/player_stat_entity.dart';
import '../../data/entities/team_stat_entity.dart';
import '../bloc/game_bloc.dart';
import '../bloc/game_event.dart';
import '../bloc/game_state.dart';

class GamePage extends StatelessWidget {
  final String gameId;
  final MatchEntity match;

  const GamePage({super.key, required this.gameId, required this.match});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GameBloc>(),
      child: _GamePageView(gameId: gameId, match: match),
    );
  }
}

class _GamePageView extends StatefulWidget {
  final String gameId;
  final MatchEntity match;

  const _GamePageView({required this.gameId, required this.match});

  @override
  State<_GamePageView> createState() => _GamePageViewState();
}

class _GamePageViewState extends State<_GamePageView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    // Загружаем статистику команд по умолчанию
    context.read<GameBloc>().add(GetTeamStatsByGameIdEvent(widget.gameId));
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) return;

    switch (_tabController.index) {
      case 0:
        context.read<GameBloc>().add(GetTeamStatsByGameIdEvent(widget.gameId));
        break;
      case 1:
        context
            .read<GameBloc>()
            .add(GetMatchLineUpStatsByGameIdEvent(widget.gameId));
        break;
      case 2:
        context
            .read<GameBloc>()
            .add(GetPlayerStatsByGameIdEvent(widget.gameId));
        break;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF4B79CF),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Статистика матча",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.star_border,
              color: Colors.white,
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: "Статистика"),
            Tab(text: "Состав"),
            Tab(text: "Статистика игроков"),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          labelStyle: TextStyle(fontSize: 12.sp),
        ),
      ),
      body: Column(
        children: [
          // Заголовок с результатом матча
          _buildGameHeader(),

          // Содержимое табов
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTeamStatsTab(),
                _buildLineupTab(),
                _buildPlayerStatsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameHeader() {
    return Container(
      color: const Color(0xFF4B79CF),
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: Colors.blue,
                        size: 24.w,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.match.homeTeam.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  "${widget.match.homeTeam.score}-${widget.match.awayTeam.score}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: Colors.red,
                        size: 24.w,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.match.awayTeam.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
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
    );
  }

  Widget _buildTeamStatsTab() {
    return BlocBuilder<GameBloc, GetGameState>(
      builder: (context, state) {
        if (state is GetTeamStatsByGameIdLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetTeamStatsByGameIdLoadedState) {
          return _buildTeamStatsContent(state.result);
        } else if (state is GetTeamStatsByGameIdFailedState) {
          return Center(
            child: Text("Ошибка загрузки: ${state.failureData.message}"),
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildTeamStatsContent(TeamsStatsResponseEntity statsResponse) {
    final teams = statsResponse.data.teams;
    if (teams.length < 2) return const SizedBox();

    final homeTeam = teams[0];
    final awayTeam = teams[1];

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          _buildStatRow(
              "Владение мячом",
              "${homeTeam.stats.possession.toInt()}%",
              "${awayTeam.stats.possession.toInt()}%",
              homeTeam.stats.possession,
              awayTeam.stats.possession),
          _buildStatRow(
              "Удары",
              "${homeTeam.stats.shot}",
              "${awayTeam.stats.shot}",
              homeTeam.stats.shot.toDouble(),
              awayTeam.stats.shot.toDouble()),
          _buildStatRow(
              "Удары в створ",
              "${homeTeam.stats.shotsOnGoal}",
              "${awayTeam.stats.shotsOnGoal}",
              homeTeam.stats.shotsOnGoal.toDouble(),
              awayTeam.stats.shotsOnGoal.toDouble()),
          _buildStatRow(
              "Удары мимо",
              "${homeTeam.stats.shotsOffGoal}",
              "${awayTeam.stats.shotsOffGoal}",
              homeTeam.stats.shotsOffGoal.toDouble(),
              awayTeam.stats.shotsOffGoal.toDouble()),
          _buildStatRow(
              "Фолы",
              "${homeTeam.stats.foul}",
              "${awayTeam.stats.foul}",
              homeTeam.stats.foul.toDouble(),
              awayTeam.stats.foul.toDouble()),
          _buildStatRow(
              "Желтые карточки",
              "${homeTeam.stats.yellowCards}",
              "${awayTeam.stats.yellowCards}",
              homeTeam.stats.yellowCards.toDouble(),
              awayTeam.stats.yellowCards.toDouble()),
          _buildStatRow(
              "Передачи",
              "${homeTeam.stats.pass}",
              "${awayTeam.stats.pass}",
              homeTeam.stats.pass.toDouble(),
              awayTeam.stats.pass.toDouble()),
          _buildStatRow(
              "Офсайды",
              "${homeTeam.stats.offside}",
              "${awayTeam.stats.offside}",
              homeTeam.stats.offside.toDouble(),
              awayTeam.stats.offside.toDouble()),
          _buildStatRow(
              "Угловые",
              "${homeTeam.stats.corner}",
              "${awayTeam.stats.corner}",
              homeTeam.stats.corner.toDouble(),
              awayTeam.stats.corner.toDouble()),
        ],
      ),
    );
  }

  Widget _buildStatRow(String title, String leftValue, String rightValue,
      double leftPercent, double rightPercent) {
    final maxValue = leftPercent > rightPercent ? leftPercent : rightPercent;
    final leftWidth = maxValue > 0 ? (leftPercent / maxValue) : 0.0;
    final rightWidth = maxValue > 0 ? (rightPercent / maxValue) : 0.0;

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(leftValue,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
              Text(title,
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
              Text(rightValue,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600)),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: leftWidth,
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Container(
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: rightWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLineupTab() {
    return BlocBuilder<GameBloc, GetGameState>(
      builder: (context, state) {
        if (state is GetMatchLineUpStatsByGameIdLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetMatchLineUpStatsByGameIdLoadedState) {
          return _buildLineupContent(state.result);
        } else if (state is GetMatchLineUpStatsByGameIdFailedState) {
          return Center(
            child: Text("Ошибка загрузки: ${state.failureData.message}"),
          );
        }
        return const Center(
          child: Text("Выберите вкладку 'Состав' для загрузки состава"),
        );
      },
    );
  }

  Widget _buildLineupContent(MatchLineupEntity lineup) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Информация о судьях
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Судейская бригада",
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.h),
                if (lineup.referees.main != null)
                  _buildRefereeRow("Главный судья:", lineup.referees.main!),
                if (lineup.referees.firstAssistant != null)
                  _buildRefereeRow(
                      "1-й помощник:", lineup.referees.firstAssistant!),
                if (lineup.referees.secondAssistant != null)
                  _buildRefereeRow(
                      "2-й помощник:", lineup.referees.secondAssistant!),
                if (lineup.referees.fourthReferee != null)
                  _buildRefereeRow(
                      "4-й судья:", lineup.referees.fourthReferee!),
              ],
            ),
          ),
          SizedBox(height: 16.h),

          // Составы команд
          _buildTeamLineup(lineup.homeTeam),
          SizedBox(height: 16.h),
          _buildTeamLineup(lineup.awayTeam),
        ],
      ),
    );
  }

  Widget _buildRefereeRow(String title, String name) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120.w,
            child: Text(
              title,
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
          ),
          Expanded(
            child: Text(
              name,
              style: TextStyle(fontSize: 12.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamLineup(TeamLineupEntity team) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (team.basLogoPath != null)
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.r),
                    image: DecorationImage(
                      image: NetworkImage(team.basLogoPath!),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              else
                Container(
                  width: 24.w,
                  height: 24.w,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Icon(
                    Icons.sports_soccer,
                    size: 16.w,
                    color: Colors.grey[600],
                  ),
                ),
              SizedBox(width: 8.w),
              Text(
                team.name,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            "Тренерский штаб",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          _buildCoachRow("Главный тренер", team.coach.fullName),
          _buildCoachRow("Ассистенты",
              "${team.firstAssistant.fullName}, ${team.secondAssistant.fullName}"),
          SizedBox(height: 16.h),
          Text(
            "Игроки",
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          ...team.lineup.map((player) => _buildPlayerRow(player)),
        ],
      ),
    );
  }

  Widget _buildCoachRow(String role, String name) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          Icon(Icons.person, size: 16.w, color: Colors.grey[600]),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(role,
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
                Text(name, style: TextStyle(fontSize: 12.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(LineupPlayerEntity player) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        children: [
          Container(
            width: 24.w,
            height: 24.w,
            decoration: BoxDecoration(
              color: player.isGk ? Colors.orange : Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                "${player.number}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      player.fullName,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w500),
                    ),
                    if (player.isCaptain) ...[
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.w, vertical: 1.h),
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.circular(2.r),
                        ),
                        child: Text(
                          "C",
                          style: TextStyle(
                              fontSize: 8.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    if (player.isGk) ...[
                      SizedBox(width: 4.w),
                      Text(
                        "ВР",
                        style: TextStyle(fontSize: 10.sp, color: Colors.orange),
                      ),
                    ],
                  ],
                ),
                Text(
                  player.isGk ? "Вратарь" : "Полевой игрок",
                  style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerStatsTab() {
    return BlocBuilder<GameBloc, GetGameState>(
      builder: (context, state) {
        if (state is GetPlayerStatsByGameIdLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetPlayerStatsByGameIdLoadedState) {
          return _buildPlayerStatsContent(state.result);
        } else if (state is GetPlayerStatsByGameIdFailedState) {
          return Center(
            child: Text("Ошибка загрузки: ${state.failureData.message}"),
          );
        }
        return const Center(
          child: Text("Выберите вкладку 'Статистика игроков' для загрузки"),
        );
      },
    );
  }

  Widget _buildPlayerStatsContent(PlayersStatsResponseEntity statsResponse) {
    final players = statsResponse.data.players;
    final teamNames = statsResponse.data.teamNames;

    return DefaultTabController(
      length: teamNames.length,
      child: Column(
        children: [
          if (teamNames.isNotEmpty)
            Container(
              color: Colors.white,
              child: TabBar(
                tabs: teamNames.map((teamName) => Tab(text: teamName)).toList(),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFF4B79CF),
              ),
            ),
          Expanded(
            child: TabBarView(
              children: teamNames.map((teamName) {
                final teamPlayers =
                    statsResponse.data.getPlayersByTeam(teamName);
                return _buildTeamPlayerStats(teamPlayers);
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamPlayerStats(List<PlayerEntity> players) {
    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        "${player.number}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          player.fullName,
                          style: TextStyle(
                              fontSize: 14.sp, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          player.team,
                          style: TextStyle(
                              fontSize: 12.sp, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 16.w,
                runSpacing: 8.h,
                children: [
                  _buildPlayerStatChip(
                      "Удары: ${player.stats.shot}", Colors.blue),
                  _buildPlayerStatChip(
                      "В створ: ${player.stats.shotsOnGoal}", Colors.green),
                  _buildPlayerStatChip(
                      "Мимо: ${player.stats.shotsOffGoal}", Colors.orange),
                  _buildPlayerStatChip(
                      "Фолы: ${player.stats.foul}", Colors.red),
                  _buildPlayerStatChip("Желтые: ${player.stats.yellowCards}",
                      Colors.yellow.shade700),
                  _buildPlayerStatChip(
                      "Передачи: ${player.stats.pass}", Colors.purple),
                  _buildPlayerStatChip(
                      "Офсайды: ${player.stats.offside}", Colors.grey),
                  _buildPlayerStatChip(
                      "Угловые: ${player.stats.corner}", Colors.teal),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPlayerStatChip(String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          color: color.withOpacity(0.8),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
