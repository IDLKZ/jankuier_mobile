import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_route_constants.dart';
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
import '../../../blog/data/entities/news_entity.dart';
import '../../../blog/domain/parameters/get_news_parameter.dart';
import '../../../blog/presentation/bloc/get_news/get_news_bloc.dart';
import '../../../blog/presentation/bloc/get_news/get_news_event.dart';
import '../../../blog/presentation/bloc/get_news/get_news_state.dart';

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
  late GetNewsBloc _newsBloc;
  late TabController _tabController;
  final GetTournamentParameter _params = const GetTournamentParameter();
  bool _hasMainCountry = false;
  TournamentEntity? _selectedTournament;

  @override
  void initState() {
    super.initState();
    _tournamentBloc = getIt<GetTournamentBloc>();
    _standingBloc = getIt<StandingBloc>();
    _newsBloc = getIt<GetNewsBloc>();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_onTabChanged);
    _checkMainCountry();
    _loadNews();
  }

  Future<void> _checkMainCountry() async {
    final mainSelectionService = getIt<MainSelectionService>();
    final hasCountry = await mainSelectionService.hasMainCountry();

    setState(() {
      _hasMainCountry = hasCountry;
    });
    
    // Загружаем турниры независимо от выбранной страны
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
    setState(() {});
    _loadTabData();
  }

  void _loadTabData() {
    if (_selectedTournament == null) return;
    
    if (_tabController.index == 0) {
      // Load standings table
      _standingBloc.add(LoadStandingsTableFromSotaEvent());
    } else {
      // Load matches
      final latestSeason = _selectedTournament!.seasons.isNotEmpty
          ? _selectedTournament!.seasons
              .reduce((current, next) => 
                  current.startDate.isAfter(next.startDate) ? current : next)
          : null;
      
      final parameter = MatchParameter(
        tournamentId: _selectedTournament!.id,
        seasonId: latestSeason?.id ?? 0,
      );
      _standingBloc.add(LoadMatchesFromSotaEvent(parameter));
    }
  }

  void _loadNews() {
    _newsBloc.add(GetNewsFromKffEvent(const GetNewsParameter(
      platform: NewsPlatform.yii,
      page: 1,
      perPage: 3,
    )));
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tournamentBloc.close();
    _standingBloc.close();
    _newsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _tournamentBloc),
        BlocProvider.value(value: _standingBloc),
        BlocProvider.value(value: _newsBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Blue header
            _buildHeader(),
            // Content with scroll
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Tournament selection section
                    _buildTournamentSection(),
                    // Main tournament card
                    if (_selectedTournament != null)
                      _buildMainTournamentCard(),
                    // Tabs and content
                    _selectedTournament != null
                        ? _buildTabsSectionWithScroll()
                        : _buildSelectTournamentMessage(),
                    // News section
                    if (_selectedTournament != null) _buildNewsSection(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 120.h,
      decoration: const BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Главная',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 40.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Text(
                        'KZ',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Container(
                    width: 40.w,
                    height: 32.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTournamentSection() {
    return Container(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Турниры',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 16.h),
          _buildTournamentCarousel(),
        ],
      ),
    );
  }

  Widget _buildMainTournamentCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60.w,
            height: 60.h,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: _selectedTournament?.image != null
                ? ClipOval(
                    child: _buildTournamentImage(_selectedTournament!.image!),
                  )
                : Icon(
                    Icons.sports_soccer,
                    color: Colors.grey,
                    size: 30.sp,
                  ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selectedTournament?.name != null
                ? Text(
                  _selectedTournament!.name,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
                : Text(
                  'ПРЕМЬЕР ЛИГА',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Казахстана',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
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
        _buildTournamentCarousel(),
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
            ? Border.all(color: AppColors.gradientStart, width: 2)
            : null,
          boxShadow: [
            BoxShadow(
              color: isSelected 
                ? AppColors.gradientStart.withValues(alpha: 0.3)
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
        width: 40.h,
        height: 40.h,
        fit: BoxFit.fitHeight,
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
          Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              color: AppColors.gradientStart.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60.w,
                  height: 60.h,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.gradientStart.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                Icon(
                  Icons.sports_soccer,
                  size: 32.sp,
                  color: AppColors.gradientStart,
                ),
              ],
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Загрузка турниров...',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.gradientStart,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Пожалуйста, подождите',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabsSection() {
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
                    _tabController.animateTo(0);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: _tabController.index == 0
                        ? AppColors.primaryGradient
                        : null,
                      color: _tabController.index == 0
                        ? null
                        : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Таблица',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: _tabController.index == 0
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
                    _tabController.animateTo(1);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: _tabController.index == 1
                        ? AppColors.primaryGradient
                        : null,
                      color: _tabController.index == 1
                        ? null
                        : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Результаты',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: _tabController.index == 1
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
    );
  }

  Widget _buildTabsSectionWithScroll() {
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
                    _tabController.animateTo(0);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: _tabController.index == 0
                        ? AppColors.primaryGradient
                        : null,
                      color: _tabController.index == 0
                        ? null
                        : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Таблица',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: _tabController.index == 0
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
                    _tabController.animateTo(1);
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    decoration: BoxDecoration(
                      gradient: _tabController.index == 1
                        ? AppColors.primaryGradient
                        : null,
                      color: _tabController.index == 1
                        ? null
                        : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        'Результаты',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: _tabController.index == 1
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
        _tabController.index == 0
          ? _buildTableTabWithoutExpanded()
          : _buildResultsTabWithoutExpanded(),
      ],
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

  Widget _buildTableTabWithoutExpanded() {
    return BlocBuilder<StandingBloc, GetStandingState>(
      builder: (context, state) {
        if (state is GetStandingsTableFromSotaLoadingState) {
          return Container(
            height: 200.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is GetStandingsTableFromSotaLoadedState) {
          return _buildStandingsTableWithoutExpanded(state.result);
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
        if (state is GetMatchesFromSotaLoadingState) {
          return Container(
            height: 200.h,
            child: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is GetMatchesFromSotaLoadedState) {
          return _buildMatchesListWithoutExpanded(state.result);
        } else if (state is GetMatchesFromSotaFailedState) {
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
            ),
          );
        }
        return Container(
          height: 100.h,
          child: const Center(
            child: Text("Выберите вкладку 'Результаты' для загрузки матчей"),
          ),
        );
      },
    );
  }

  Widget _buildStandingsTable(List<ScoreTableTeamEntity> teams) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
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
                  width: 30.w,
                  child: Text(
                    "№",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Команда",
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
                    "И",
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
                    "Г",
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
                  width: 30.w,
                  child: Text(
                    "О",
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
          // Teams list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
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

  Widget _buildStandingsTableWithoutExpanded(List<ScoreTableTeamEntity> teams) {
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
                  width: 30.w,
                  child: Text(
                    "№",
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    "Команда",
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
                    "И",
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
                    "Г",
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
                  width: 30.w,
                  child: Text(
                    "О",
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

  Widget _buildMatchesList(List<MatchEntity> matches) {
    final groupedMatches = <int, List<MatchEntity>>{};

    for (final match in matches) {
      if (!groupedMatches.containsKey(match.tour)) {
        groupedMatches[match.tour] = [];
      }
      groupedMatches[match.tour]!.add(match);
    }

    return Container(
      color: AppColors.background,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: groupedMatches.keys.length,
        itemBuilder: (context, index) {
          final tour = groupedMatches.keys.elementAt(index);
          final tourMatches = groupedMatches[tour]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Tour header
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Text(
                  "Тур $tour",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              // Matches for this tour
              ...tourMatches.map((match) => _buildMatchCard(match)),
              SizedBox(height: 16.h),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMatchesListWithoutExpanded(List<MatchEntity> matches) {
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
                  "Тур $tour",
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
              // Matches for this tour
              ...tourMatches.map((match) => _buildMatchCardWithoutMargin(match)),
              SizedBox(height: 16.h),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildMatchCard(MatchEntity match) {
    return GestureDetector(
      onTap: () {
        context.push('${AppRouteConstants.GameStatPagePath}${match.id}',
            extra: match);
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
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
                    _formatDate(match.date),
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
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

  Widget _buildTeamImage(String imageUrl) {
    final isSvg = imageUrl.toLowerCase().endsWith('.svg') ||
        imageUrl.toLowerCase().contains('.svg?');

    if (isSvg) {
      return SvgPicture.network(
        imageUrl,
        width: 32.w,
        height: 32.h,
        fit: BoxFit.contain,
        placeholderBuilder: (context) => _buildTeamImagePlaceholder(),
      );
    } else {
      return Image.network(
        imageUrl,
        width: 32.w,
        height: 32.h,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) => _buildTeamImagePlaceholder(),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return _buildTeamImagePlaceholder();
        },
      );
    }
  }

  Widget _buildTeamImagePlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: Icon(
        Icons.sports_soccer,
        color: Colors.grey,
        size: 20.sp,
      ),
    );
  }

  Widget _buildMatchCardWithoutMargin(MatchEntity match) {
    return GestureDetector(
      onTap: () {
        context.push('${AppRouteConstants.GameStatPagePath}${match.id}',
            extra: match);
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
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
                    _formatDate(match.date),
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
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.sports_soccer,
                      color: Colors.grey,
                      size: 24.sp,
                    ),
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

  Widget _buildNewsSection() {
    return Container(
      margin: EdgeInsets.only(top: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Последние новости',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    context.push('/blog');
                  },
                  child: Text(
                    'Все новости',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gradientStart,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          BlocBuilder<GetNewsBloc, GetNewsStateState>(
            builder: (context, state) {
              if (state is GetNewsStateLoadingState) {
                return Container(
                  height: 150.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: const Center(child: CircularProgressIndicator()),
                );
              } else if (state is GetNewsStateSuccessState) {
                if (state.newsResponse.data.isEmpty) {
                  return Container(
                    height: 150.h,
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Center(
                      child: Text(
                        'Новости не найдены',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  );
                }
                return SizedBox(
                  height: 200.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: state.newsResponse.data.length,
                    itemBuilder: (context, index) {
                      final news = state.newsResponse.data[index];
                      return Container(
                        width: 280.w,
                        margin: EdgeInsets.only(right: 16.w),
                        child: _buildNewsCard(news),
                      );
                    },
                  ),
                );
              } else if (state is GetNewsStateFailedState) {
                return Container(
                  height: 150.h,
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Text(
                      'Ошибка загрузки новостей',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.red,
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox();
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildNewsCard(News news) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(12),
            ),
            child: Container(
              height: 120.h,
              width: double.infinity,
              color: Colors.grey[200],
              child: news.imageUrl != null && news.imageUrl!.isNotEmpty
                  ? Image.network(
                      news.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.image_not_supported,
                            color: Colors.grey[400],
                            size: 40.sp,
                          ),
                        );
                      },
                    )
                  : Icon(
                      Icons.article,
                      color: Colors.grey[400],
                      size: 40.sp,
                    ),
            ),
          ),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.title,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 12.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatNewsDate(news.date?.toIso8601String() ?? ''),
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.visibility,
                        size: 12.sp,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '${news.views ?? 0}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatNewsDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} дн. назад';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ч. назад';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} мин. назад';
      } else {
        return 'Только что';
      }
    } catch (e) {
      return dateString;
    }
  }
}
