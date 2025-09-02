import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/sota_api_constants.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/main_selection_service.dart';
import '../../../standings/data/entities/match_entity.dart';
import '../../../standings/data/entities/score_table_team_entity.dart';
import '../../../standings/domain/parameters/match_parameter.dart';
import '../../../standings/presentation/bloc/standing_bloc.dart';
import '../../../standings/presentation/bloc/standing_event.dart';
import '../../../standings/presentation/bloc/standing_state.dart';
import '../../../standings/presentation/widgets/match_item_widget.dart';
import '../../../standings/presentation/widgets/team_table_item_widget.dart';
import '../../../tournament/data/entities/tournament_entity.dart';
import '../../../tournament/domain/parameters/get_tournament_parameter.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_bloc.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_event.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_state.dart';

class HomePage extends StatefulWidget {
  final Function(int tournamentId, String tournamentName)? onTournamentSelected;
  final int? selectedTournamentId;

  const HomePage({
    super.key,
    this.onTournamentSelected,
    this.selectedTournamentId,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late GetTournamentBloc _tournamentBloc;
  late StandingBloc _standingBloc;
  late TabController _tabController;
  final GetTournamentParameter _params = const GetTournamentParameter();
  bool _hasMainCountry = false;
  TournamentEntity? _selectedTournament;

  @override
  void initState() {
    super.initState();
    _tournamentBloc = getIt<GetTournamentBloc>();
    _standingBloc = getIt<StandingBloc>();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _checkMainCountry();
  }

  Future<void> _checkMainCountry() async {
    final mainSelectionService = getIt<MainSelectionService>();
    final hasCountry = await mainSelectionService.hasMainCountry();

    if (!hasCountry) {
      setState(() {
        _hasMainCountry = false;
      });
      return;
    }

    setState(() {
      _hasMainCountry = true;
    });
    _loadTournaments();
  }

  void _loadTournaments() {
    _tournamentBloc.add(GetTournamentEvent(_params));
  }

  void _onTournamentSelected(TournamentEntity tournament) async {
    setState(() {
      _selectedTournament = tournament;
    });
    
    // Save tournament and load data based on current tab
    try {
      final mainSelectionService = getIt<MainSelectionService>();
      await mainSelectionService.saveMainTournament(tournament);
      
      // Load data for current tab
      _loadTabData();
    } catch (e) {
      // Handle error
      print('Error saving tournament: $e');
    }
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging || _selectedTournament == null) return;
    _loadTabData();
  }

  void _loadTabData() {
    if (_selectedTournament == null) return;
    
    if (_tabController.index == 0) {
      // Load standings table
      _standingBloc.add(LoadStandingsTableFromSotaEvent());
    } else {
      // Load matches
      final parameter = MatchParameter(
        tournamentId: _selectedTournament!.id,
        seasonId: _selectedTournament!.seasons.isNotEmpty 
          ? _selectedTournament!.seasons.first.id 
          : 0,
      );
      _standingBloc.add(LoadMatchesFromSotaEvent(parameter));
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tournamentBloc.close();
    _standingBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _tournamentBloc),
        BlocProvider.value(value: _standingBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top League section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    _buildTopLeagueSection(),
                    if (_selectedTournament != null) ...[
                      SizedBox(height: 20.h),
                      Text(
                        _selectedTournament!.name,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Tabs and content
              Expanded(
                child: _selectedTournament != null
                    ? _buildTabsSection()
                    : _buildSelectTournamentMessage(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopLeagueSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Top League',
          style: TextStyle(
            fontFamily: 'Inter',
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16.h),
        _hasMainCountry ? _buildTournamentCarousel() : _buildLoadingCarousel(),
      ],
    );
  }

  Widget _buildTournamentCarousel() {
    return BlocBuilder<GetTournamentBloc, GetTournamentStateState>(
      builder: (context, state) {
        if (state is GetTournamentStateLoadingState) {
          return _buildLoadingCarousel();
        } else if (state is GetTournamentStateSuccessState) {
          // Filter only football tournaments with seasons (like in tournament_selection_grid.dart)
          const excludedSeasonIds = [92, 71, 24, 108, 17];
          final tournaments = state.tournaments.results
              .where((tournament) =>
                  tournament.sport == SotaApiConstant.FootballID &&
                  tournament.seasons.isNotEmpty &&
                  tournament.image != null &&
                  tournament.image!.isNotEmpty &&
                  !tournament.seasons.any((season) => excludedSeasonIds.contains(season.id))
          )
              // .take(6) // Limit to 6 tournaments for carousel
              .toList();

          if (tournaments.isEmpty) {
            return _buildEmptyState();
          }

          // Auto-select first tournament if none selected
          if (_selectedTournament == null && tournaments.isNotEmpty) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onTournamentSelected(tournaments.first);
            });
          }

          return _buildLeagueCarousel(tournaments);
        } else if (state is GetTournamentStateFailedState) {
          return _buildErrorState();
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildLeagueCarousel(List<TournamentEntity> tournaments) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tournaments.length,
        itemBuilder: (context, index) {
          final tournament = tournaments[index];
          return Container(
            margin: EdgeInsets.only(right: 16.w),
            child: _buildLeagueItem(tournament),
          );
        },
      ),
    );
  }

  Widget _buildLeagueItem(TournamentEntity tournament) {
    final isSelected = _selectedTournament?.id == tournament.id;
    
    return GestureDetector(
      onTap: () {
        _onTournamentSelected(tournament);
      },
      child: Container(
        width: 50.h,
        height: 50.h,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: isSelected 
            ? Border.all(color: const Color(0xFF4B79CF), width: 2)
            : null,
          boxShadow: [
            BoxShadow(
              color: isSelected 
                ? const Color(0xFF4B79CF).withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ClipOval(
          child: _buildTournamentImage(tournament.image!),
        ),
      ),
    );
  }

  Widget _buildTournamentImage(String imageUrl) {
    final isSvg = imageUrl.toLowerCase().endsWith('.svg') ||
        imageUrl.toLowerCase().contains('.svg?');

    if (isSvg) {
      return SvgPicture.network(
        imageUrl,
        width: 40.h,
        height: 40.h,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => _buildImagePlaceholder(),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 20.h,
        height: 20.h,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildImagePlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildImagePlaceholder();
        },
      );
    }
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Icon(
        Icons.sports_soccer,
        color: Colors.grey,
        size: 30,
      ),
    );
  }

  Widget _buildLoadingCarousel() {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 6,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.only(right: 16.w),
            width: 50.h,
            height: 50.h,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return SizedBox(
      height: 70.h,
      child: Center(
        child: Text(
          'Турниры не найдены',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return SizedBox(
      height: 70.h,
      child: Center(
        child: Text(
          'Ошибка загрузки турниров',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Widget _buildSelectTournamentMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.sports_soccer_outlined,
            size: 64.sp,
            color: Colors.grey[400],
          ),
          SizedBox(height: 16.h),
          Text(
            'Выберите турнир',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Нажмите на логотип лиги выше',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsSection() {
    return Container(
      margin: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          // Tab bar
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
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildTableTab(),
                _buildResultsTab(),
              ],
            ),
          ),
        ],
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
                  "Ошибка загрузки турнирной таблицы",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.failureData.message ?? 'Неизвестная ошибка',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
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
                  "Ошибка загрузки результатов матчей",
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.red[600],
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  state.failureData.message ?? 'Неизвестная ошибка',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }
        return const Center(
          child: Text("Выберите вкладку 'Результаты' для загрузки матчей"),
        );
      },
    );
  }

  Widget _buildStandingsTable(List<ScoreTableTeamEntity> teams) {
    return Container(
      color: Colors.grey[50],
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            color: Colors.white,
            child: Row(
              children: [
                SizedBox(
                  width: 30.w,
                  child: Text(
                    "№",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Команда",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                  child: Text(
                    "И",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 50.w,
                  child: Text(
                    "Г",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30.w,
                  child: Text(
                    "О",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Teams list
          Expanded(
            child: ListView.builder(
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
