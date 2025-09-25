import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_match_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/tournaments/tournaments_state.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/entities/kff_league_tournament_entity.dart';
import '../bloc/matches/matches_bloc.dart';
import '../bloc/matches/matches_event.dart';
import '../bloc/matches/matches_state.dart';
import '../bloc/tournaments/tournaments_bloc.dart';
import '../bloc/tournaments/tournaments_event.dart';
import '../widgets/horizontal_tournaments_list.dart';
import '../widgets/match_card_widget.dart';

class KffLeagueClubPage extends StatefulWidget {
  const KffLeagueClubPage({super.key});

  @override
  State<KffLeagueClubPage> createState() => _KffLeagueClubPageState();
}

class _KffLeagueClubPageState extends State<KffLeagueClubPage>
    with SingleTickerProviderStateMixin {
  late TournamentsBloc _tournamentsBloc;
  late MatchesBloc _matchesBloc;
  late TabController _tabController;

  final KffLeagueClubMatchParameters matchParameters =
      KffLeagueClubMatchParameters();

  int? selectedTournamentId;
  KffLeagueTournamentSeasonEntity? selectedSeason;

  // Single scroll controller for the entire page
  final ScrollController _pageScrollController = ScrollController();

  // Current page trackers
  int _futureMatchesPage = 1;
  int _pastMatchesPage = 1;

  // Hive box for storing preferences
  late Box _preferencesBox;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tournamentsBloc = getIt<TournamentsBloc>()..add(LoadTournaments());
    _matchesBloc = getIt<MatchesBloc>();

    // Setup scroll listener for pagination
    _pageScrollController.addListener(_onPageScroll);

    // Initialize Hive box
    _initHiveBox();
  }

  Future<void> _initHiveBox() async {
    _preferencesBox = await Hive.openBox('kff_preferences');
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageScrollController.dispose();
    _tournamentsBloc.close();
    _matchesBloc.close();
    super.dispose();
  }

  void _onTournamentSelected(KffLeagueTournamentSeasonEntity season) {
    setState(() {
      selectedTournamentId = season.tournamentId;
      selectedSeason = season;
      // Reset page counters when selecting new tournament
      _futureMatchesPage = 1;
      _pastMatchesPage = 1;
    });

    // Save selected tournament and season to Hive
    _saveSelectedTournament(season);

    // Load matches for currently selected tab
    _loadMatchesForCurrentTab(season);
  }

  Future<void> _saveSelectedTournament(
      KffLeagueTournamentSeasonEntity season) async {
    try {
      await _preferencesBox.put('ActiveKffTournamentId', season.tournamentId);
      await _preferencesBox.put('ActiveKffSeasonId', season.season?.id);
    } catch (e) {
      // Handle error silently for now
      debugPrint('Error saving tournament selection: $e');
    }
  }

  void _loadSavedTournamentSelection(
      List<KffLeagueTournamentWithSeasonsEntity> tournaments) {
    // Only auto-select if none is currently selected
    if (selectedTournamentId != null) return;

    try {
      final savedTournamentId = _preferencesBox.get('ActiveKffTournamentId');
      final savedSeasonId = _preferencesBox.get('ActiveKffSeasonId');

      if (savedTournamentId != null) {
        // Try to find the saved tournament and season
        for (final tournament in tournaments) {
          if (tournament.seasons != null) {
            for (final season in tournament.seasons!) {
              if (season.tournamentId == savedTournamentId &&
                  (savedSeasonId == null ||
                      season.season?.id == savedSeasonId)) {
                _onTournamentSelected(season);
                return;
              }
            }
          }
        }
      }

      // If no saved selection found or saved tournament not available, select first available
      for (final tournament in tournaments) {
        if (tournament.seasons != null && tournament.seasons!.isNotEmpty) {
          _onTournamentSelected(tournament.seasons!.first);
          return;
        }
      }
    } catch (e) {
      // If error reading from Hive, fallback to first tournament
      debugPrint('Error loading saved tournament selection: $e');
      for (final tournament in tournaments) {
        if (tournament.seasons != null && tournament.seasons!.isNotEmpty) {
          _onTournamentSelected(tournament.seasons!.first);
          return;
        }
      }
    }
  }

  void _loadMatchesForCurrentTab(KffLeagueTournamentSeasonEntity season) {
    final currentTabIndex = _tabController.index;
    _loadMatchesForTab(currentTabIndex, season);
  }

  void _loadMatchesForTab(
      int tabIndex, KffLeagueTournamentSeasonEntity season) {
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000; // Unix timestamp

    KffLeagueClubMatchParameters params;

    switch (tabIndex) {
      case 0: // Future matches
        _futureMatchesPage = 1; // Reset page counter
        params = KffLeagueClubMatchParameters(
          tournamentId: season.tournamentId,
          seasonId: season.season?.id,
          order: 'oldest',
          dateFrom: now,
          page: _futureMatchesPage,
          perPage: 20,
        );
        break;
      case 1: // Past matches
        _pastMatchesPage = 1; // Reset page counter
        params = KffLeagueClubMatchParameters(
          tournamentId: season.tournamentId,
          seasonId: season.season?.id,
          order: 'latest',
          dateTo: now,
          page: _pastMatchesPage,
          perPage: 20,
        );
        break;
      default:
        return;
    }

    _matchesBloc.add(LoadMatches(params));
  }

  void _onPageScroll() {
    if (_pageScrollController.position.pixels >=
        _pageScrollController.position.maxScrollExtent - 200) {
      // Load more matches based on current tab
      _loadMoreMatches(_tabController.index);
    }
  }

  void _loadMoreMatches(int tabIndex) {
    if (selectedSeason == null) return;

    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    KffLeagueClubMatchParameters params;

    switch (tabIndex) {
      case 0: // Future matches
        _futureMatchesPage++;
        params = KffLeagueClubMatchParameters(
          tournamentId: selectedSeason!.tournamentId,
          seasonId: selectedSeason!.season?.id,
          order: 'oldest',
          dateFrom: now,
          page: _futureMatchesPage,
          perPage: 30,
        );
        break;
      case 1: // Past matches
        _pastMatchesPage++;
        params = KffLeagueClubMatchParameters(
          tournamentId: selectedSeason!.tournamentId,
          seasonId: selectedSeason!.season?.id,
          order: 'latest',
          dateTo: now,
          page: _pastMatchesPage,
          perPage: 30,
        );
        break;
      default:
        return;
    }

    _matchesBloc.add(LoadMoreMatches(params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
          title: AppLocalizations.of(context)!.clubMatches,
          leadingIcon: Icons.arrow_back_ios_new,
          actionIcon: Icons.sports_soccer,
          onActionTap: () {}),
      body: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: _tournamentsBloc),
            BlocProvider.value(value: _matchesBloc),
          ],
          child: BlocConsumer<TournamentsBloc, TournamentsState>(
            listener: (BuildContext context, TournamentsState state) {
              if (state is TournamentsLoaded) {
                if (state.tournaments.data.isNotEmpty) {
                  _loadSavedTournamentSelection(state.tournaments.data);
                }
              }
            },
            builder: (BuildContext context, TournamentsState state) {
              if (state is TournamentsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is TournamentsLoaded) {
                return CustomScrollView(
                  controller: _pageScrollController,
                  slivers: [
                    // Title Section
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Text(
                          AppLocalizations.of(context)!.tournaments,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),

                    // Horizontal Tournaments List
                    SliverToBoxAdapter(
                      child: HorizontalTournamentsList(
                        tournaments: state.tournaments.data,
                        selectedTournamentId: selectedTournamentId,
                        onTournamentTap: _onTournamentSelected,
                      ),
                    ),

                    // Tabs Section
                    if (selectedSeason != null) ...[
                      // TabBar
                      SliverToBoxAdapter(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 20.h),
                          decoration: BoxDecoration(
                            color: AppColors.grey100,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.r),
                              gradient: AppColors.primaryGradient,
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            labelColor: AppColors.white,
                            unselectedLabelColor: AppColors.textSecondary,
                            labelStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            unselectedLabelStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            onTap: (index) {
                              if (selectedSeason != null) {
                                _loadMatchesForTab(index, selectedSeason!);
                              }
                            },
                            tabs: [
                              Tab(text: AppLocalizations.of(context)!.future),
                              Tab(text: AppLocalizations.of(context)!.past),
                            ],
                          ),
                        ),
                      ),

                      // Matches List
                      _buildMatchesSliver(),
                    ],
                  ],
                );
              }
              return const SizedBox();
            },
          )),
    );
  }

  Widget _buildMatchesSliver() {
    final isFuture = _tabController.index == 0;

    return BlocBuilder<MatchesBloc, MatchesState>(
      builder: (context, state) {
        if (state is MatchesLoading) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 200.h,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        if (state is MatchesError) {
          return SliverToBoxAdapter(
            child: SizedBox(
              height: 200.h,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48.sp,
                        color: AppColors.error,
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        AppLocalizations.of(context)!.matchesLoadingError,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        state.message,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        if (state is MatchesLoaded || state is MatchesLoadingMore) {
          final matches = state is MatchesLoaded
              ? state.matches.data
              : (state as MatchesLoadingMore).currentMatches.data;

          final hasNext = state is MatchesLoaded
              ? state.matches.meta?.hasNext ?? false
              : (state as MatchesLoadingMore).currentMatches.meta?.hasNext ??
                  false;

          final isLoadingMore = state is MatchesLoadingMore;

          if (matches.isEmpty) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 200.h,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          isFuture ? Icons.schedule : Icons.history,
                          size: 48.sp,
                          color: AppColors.textSecondary,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          isFuture
                              ? AppLocalizations.of(context)!.noUpcomingMatches
                              : AppLocalizations.of(context)!.noPastMatches,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          AppLocalizations.of(context)!.matchesWillBeDisplayed,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index == matches.length) {
                  // Loading indicator at the bottom
                  return Padding(
                    padding: EdgeInsets.all(16.h),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final match = matches[index];
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: MatchCardWidget(
                    match: match,
                    isFuture: isFuture,
                  ),
                );
              },
              childCount: matches.length + (hasNext || isLoadingMore ? 1 : 0),
            ),
          );
        }

        return const SliverToBoxAdapter(
          child: SizedBox(),
        );
      },
    );
  }
}
