import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/main_selection_service.dart';
import '../../../kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart';
import '../../../kff/presentation/bloc/get_future_matches/get_future_matches_event.dart';
import '../../../kff/presentation/bloc/get_past_matches/get_past_matches_event.dart';
import '../../../standings/domain/parameters/match_parameter.dart';
import '../../../standings/presentation/bloc/standing_bloc.dart';
import '../../../standings/presentation/bloc/standing_event.dart';
import '../../../tournament/data/entities/tournament_entity.dart';
import '../../../tournament/domain/parameters/get_tournament_parameter.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_bloc.dart';
import '../../../tournament/presentation/bloc/get_tournaments/get_tournament_event.dart';
import '../../../blog/domain/parameters/get_news_parameter.dart';
import '../../../blog/presentation/bloc/get_news/get_news_bloc.dart';
import '../../../blog/presentation/bloc/get_news/get_news_event.dart';
import '../widgets/_build_future_match_widget.dart';
import '../widgets/_build_header.dart';
import '../widgets/_build_main_tournament_card.dart';
import '../widgets/_build_news_section.dart';
import '../widgets/_build_tabs_section.dart';
import '../widgets/_build_tournament_section.dart';

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
  late GetFutureMatchesBloc _futureMatchesBloc;
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
    _futureMatchesBloc = getIt<GetFutureMatchesBloc>()
      ..add(GetFutureMatchesRequestEvent(1));
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
          ? _selectedTournament!.seasons.reduce((current, next) =>
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
    _futureMatchesBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _tournamentBloc),
        BlocProvider.value(value: _standingBloc),
        BlocProvider.value(value: _newsBloc),
        BlocProvider.value(value: _futureMatchesBloc),
      ],
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            // Blue header
            buildHeader(),
            // Content with scroll
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Tournament selection section
                    buildTournamentSection(
                        _selectedTournament, _onTournamentSelected),
                    // Main tournament card
                    if (_selectedTournament != null)
                      buildMainTournamentCard(_selectedTournament),
                    // Tabs and content
                    _selectedTournament != null
                        ? buildTabsSectionWithScroll(
                            _tabController, () => setState(() {}))
                        : _buildSelectTournamentMessage(),
                    // Future Match
                    if (_selectedTournament != null) buildFutureMatch(context),
                    // News section
                    if (_selectedTournament != null) buildNewsSection(context),
                  ],
                ),
              ),
            ),
          ],
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
}
