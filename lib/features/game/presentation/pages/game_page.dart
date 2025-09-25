import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/standings/data/entities/match_entity.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/app_localizations.dart';
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
    setState(() {});

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
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Blue header
          _buildHeader(context),
          // Content
          Expanded(
            child: Column(
              children: [
                // Match info card
                _buildMatchInfoCard(),
                // Custom tabs
                _buildCustomTabs(),
                // Tab content
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
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: 120.h,
      decoration: const BoxDecoration(
        color: Color(0xFF1E4B9B),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${AppLocalizations.of(context)!.round} ${widget.match.tour}',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 40.w), // Balance the back button
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMatchInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Match info
          Row(
            children: [
              // Home team
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: Colors.grey,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.match.homeTeam.name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
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
              // Score
              Column(
                children: [
                  Text(
                    "${widget.match.homeTeam.score}:${widget.match.awayTeam.score}",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _formatDate(widget.match.date),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF1E4B9B),
                    ),
                  ),
                ],
              ),
              // Away team
              Expanded(
                child: Column(
                  children: [
                    Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.sports_soccer,
                        color: Colors.grey,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      widget.match.awayTeam.name,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
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
        ],
      ),
    );
  }

  Widget _buildCustomTabs() {
    return Container(
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
                _tabController.animateTo(0);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: _tabController.index == 0
                      ? const Color(0xFF1E4B9B)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.statistics,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: _tabController.index == 0
                          ? Colors.white
                          : const Color(0xFF1E4B9B),
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
                _tabController.animateTo(1);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: _tabController.index == 1
                      ? const Color(0xFF1E4B9B)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.lineup,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: _tabController.index == 1
                          ? Colors.white
                          : const Color(0xFF1E4B9B),
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
                _tabController.animateTo(2);
                setState(() {});
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                decoration: BoxDecoration(
                  color: _tabController.index == 2
                      ? const Color(0xFF1E4B9B)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of(context)!.players,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: _tabController.index == 2
                          ? Colors.white
                          : const Color(0xFF1E4B9B),
                    ),
                  ),
                ),
              ),
            ),
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
            child: Text(
                '${AppLocalizations.of(context)!.loadingErrorWithMessage}: ${state.failureData.message}'),
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

    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Team names
            Row(
              children: [
                // Home team logo and name
                Expanded(
                  child: Row(
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.sports_soccer,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.match.homeTeam.name,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                // Away team logo and name
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.match.awayTeam.name,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.sports_soccer,
                          color: Colors.grey,
                          size: 20.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            // Statistics
            Column(
              children: [
                _buildStatRow(
                    AppLocalizations.of(context)!.ballPossession,
                    "${homeTeam.stats.possession.toInt()}%",
                    "${awayTeam.stats.possession.toInt()}%",
                    homeTeam.stats.possession,
                    awayTeam.stats.possession),
                _buildStatRow(
                    AppLocalizations.of(context)!.shots,
                    "${homeTeam.stats.shot}",
                    "${awayTeam.stats.shot}",
                    homeTeam.stats.shot.toDouble(),
                    awayTeam.stats.shot.toDouble()),
                _buildStatRow(
                    AppLocalizations.of(context)!.shotsOnGoal,
                    "${homeTeam.stats.shotsOnGoal}",
                    "${awayTeam.stats.shotsOnGoal}",
                    homeTeam.stats.shotsOnGoal.toDouble(),
                    awayTeam.stats.shotsOnGoal.toDouble()),
                _buildStatRow(
                    AppLocalizations.of(context)!.shotsOffGoal,
                    "${homeTeam.stats.shotsOffGoal}",
                    "${awayTeam.stats.shotsOffGoal}",
                    homeTeam.stats.shotsOffGoal.toDouble(),
                    awayTeam.stats.shotsOffGoal.toDouble()),
                _buildStatRow(
                    AppLocalizations.of(context)!.fouls,
                    "${homeTeam.stats.foul}",
                    "${awayTeam.stats.foul}",
                    homeTeam.stats.foul.toDouble(),
                    awayTeam.stats.foul.toDouble()),
                _buildStatRow(
                    AppLocalizations.of(context)!.yellowCards,
                    "${homeTeam.stats.yellowCards}",
                    "${awayTeam.stats.yellowCards}",
                    homeTeam.stats.yellowCards.toDouble(),
                    awayTeam.stats.yellowCards.toDouble()),
              ],
            ),
          ],
        ),
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
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
              Text(title,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  )),
              Text(rightValue,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  )),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: leftWidth,
                    alignment: Alignment.centerRight,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E4B9B),
                        borderRadius: BorderRadius.circular(3.r),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5E5E5),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                  child: FractionallySizedBox(
                    widthFactor: rightWidth,
                    alignment: Alignment.centerLeft,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1E4B9B),
                        borderRadius: BorderRadius.circular(3.r),
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
            child: Text(
                '${AppLocalizations.of(context)!.loadingErrorWithMessage}: ${state.failureData.message}'),
          );
        }
        return Center(
          child: Text(AppLocalizations.of(context)!.selectLineupTabToLoad),
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
                  AppLocalizations.of(context)!.refereeTeam,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 12.h),
                if (lineup.referees.main != null)
                  _buildRefereeRow(AppLocalizations.of(context)!.mainReferee,
                      lineup.referees.main!),
                if (lineup.referees.firstAssistant != null)
                  _buildRefereeRow(AppLocalizations.of(context)!.firstAssistant,
                      lineup.referees.firstAssistant!),
                if (lineup.referees.secondAssistant != null)
                  _buildRefereeRow(
                      AppLocalizations.of(context)!.secondAssistant,
                      lineup.referees.secondAssistant!),
                if (lineup.referees.fourthReferee != null)
                  _buildRefereeRow(AppLocalizations.of(context)!.fourthReferee,
                      lineup.referees.fourthReferee!),
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
                    // image: DecorationImage(
                    //   image: NetworkImage(team.basLogoPath!),
                    //   fit: BoxFit.cover,
                    // ),
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
            AppLocalizations.of(context)!.coachingStaff,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8.h),
          _buildCoachRow(
              AppLocalizations.of(context)!.headCoach, team.coach.fullName),
          _buildCoachRow(AppLocalizations.of(context)!.assistants,
              "${team.firstAssistant.fullName}, ${team.secondAssistant.fullName}"),
          SizedBox(height: 16.h),
          Text(
            AppLocalizations.of(context)!.players,
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
                        AppLocalizations.of(context)!.goalkeeper,
                        style: TextStyle(fontSize: 10.sp, color: Colors.orange),
                      ),
                    ],
                  ],
                ),
                Text(
                  player.isGk
                      ? AppLocalizations.of(context)!.goalkeeperFull
                      : AppLocalizations.of(context)!.fieldPlayer,
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
            child: Text(
                '${AppLocalizations.of(context)!.loadingErrorWithMessage}: ${state.failureData.message}'),
          );
        }
        return Center(
          child: Text(AppLocalizations.of(context)!.selectPlayersTabToLoad),
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
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
        return Container(
          margin: EdgeInsets.only(bottom: 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Player Header
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF1E4B9B),
                      const Color(0xFF2E5BA8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    // Player Number Circle
                    Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "${player.number}",
                          style: TextStyle(
                            fontFamily: 'Inter',
                            color: const Color(0xFF1E4B9B),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Player Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.fullName,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.sports_soccer,
                                size: 14.sp,
                                color: Colors.white.withValues(alpha: 0.8),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                player.team,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white.withValues(alpha: 0.9),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // Player Statistics
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    // Key Stats Row
                    Row(
                      children: [
                        Expanded(
                          child: _buildKeyStatItem(
                            "⚽",
                            "${player.stats.shot}",
                            AppLocalizations.of(context)!.shots,
                            const Color(0xFF4CAF50),
                          ),
                        ),
                        Expanded(
                          child: _buildKeyStatItem(
                            "🎯",
                            "${player.stats.shotsOnGoal}",
                            AppLocalizations.of(context)!.onTarget,
                            const Color(0xFF2196F3),
                          ),
                        ),
                        Expanded(
                          child: _buildKeyStatItem(
                            "📊",
                            "${player.stats.pass}",
                            AppLocalizations.of(context)!.passes,
                            const Color(0xFF9C27B0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    // Additional Stats Grid
                    _buildAdditionalStats(player),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKeyStatItem(
      String emoji, String value, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      margin: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text(
            emoji,
            style: TextStyle(fontSize: 20.sp),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalStats(PlayerEntity player) {
    final stats = [
      {
        "label": AppLocalizations.of(context)!.offTarget,
        "value": "${player.stats.shotsOffGoal}",
        "icon": "❌"
      },
      {
        "label": AppLocalizations.of(context)!.fouls,
        "value": "${player.stats.foul}",
        "icon": "⚠️"
      },
      {
        "label": AppLocalizations.of(context)!.yellows,
        "value": "${player.stats.yellowCards}",
        "icon": "🟨"
      },
      {
        "label": AppLocalizations.of(context)!.offsides,
        "value": "${player.stats.offside}",
        "icon": "🚩"
      },
      {
        "label": AppLocalizations.of(context)!.corners,
        "value": "${player.stats.corner}",
        "icon": "📐"
      },
    ];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.additionalStats,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8.h),
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: stats.map((stat) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.grey.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      stat["icon"]!,
                      style: TextStyle(fontSize: 12.sp),
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      "${stat["value"]} ${stat["label"]}",
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      // Преобразуем строку в объект DateTime.
      final dateTime = DateTime.parse(dateString);

      // Получаем день, месяц и год из объекта DateTime.
      // padLeft(2, '0') добавляет ведущий ноль, если число состоит из одной цифры (например, 7 -> 07).
      final day = dateTime.day.toString().padLeft(2, '0');
      final month = dateTime.month.toString().padLeft(2, '0');
      final year = dateTime.year;

      // Собираем строку в нужном формате.
      return "$day.$month.$year";
    } catch (e) {
      // Если строка не соответствует формату, возвращаем её без изменений.
      return dateString;
    }
  }

  void main() {
    var originalDate = "2024-07-26";
    var formattedDate = _formatDate(originalDate);

    var anotherDate = "2025-01-05";
  }
}
