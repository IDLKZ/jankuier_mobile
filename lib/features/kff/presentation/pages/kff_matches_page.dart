import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_event.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
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
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Modern App Bar with Gradient
          Container(
            height: 120.h + MediaQuery.of(context).padding.top,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24.r),
                bottomRight: Radius.circular(24.r),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Column(
                  children: [
                    // Top row with icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.sports_soccer,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.notifications_outlined,
                            color: AppColors.white,
                            size: 24.sp,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Title
                    Text(
                      'KFF Матчи',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Main Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 24.h),

                  // Modern Tab Selector
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildModernTabButton(
                            'Национальные',
                            0,
                            Icons.flag_outlined,
                          ),
                        ),
                        Container(
                          width: 1.w,
                          height: 40.h,
                          color: AppColors.grey200,
                        ),
                        Expanded(
                          child: _buildModernTabButton(
                            'Клубы',
                            1,
                            Icons.shield_outlined,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Tab Content
                  Expanded(
                    child: TabBarView(
                      controller: _mainTabController,
                      children: [
                        BlocProvider<GetAllLeagueBloc>(
                          create: (BuildContext context) =>
                              getIt<GetAllLeagueBloc>()
                                ..add(GetAllLeagueRequestEvent()),
                          child:
                              BlocConsumer<GetAllLeagueBloc, GetAllLeagueState>(
                            listener: (BuildContext context, state) {},
                            builder: (BuildContext context, state) {
                              if (state is GetAllLeagueLoadingState) {
                                return _buildLoadingState();
                              } else if (state is GetAllLeagueSuccessState) {
                                return _buildLeaguesList(state.leagues);
                              } else if (state is GetAllLeagueFailedState) {
                                return _buildErrorState(
                                    state.failure.message ?? "-");
                              }
                              return const SizedBox();
                            },
                          ),
                        ),
                        _buildClubsComingSoon(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernTabButton(String title, int index, IconData icon) {
    final isSelected = _mainTabController.index == index;

    return GestureDetector(
      onTap: () => _mainTabController.animateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20.sp,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                title,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Загружаем лиги...',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.error_outline,
              size: 48.sp,
              color: AppColors.error,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Ошибка загрузки',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildClubsComingSoon() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.construction,
              size: 48.sp,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Скоро появится',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Раздел клубов находится в разработке',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLeaguesList(List<KffLeagueEntity> leagues) {
    if (leagues.isEmpty) return _buildEmptyState();

    final selectedLeagueId = leagues[selectedLeagueIndex].id;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            'Выберите лигу',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        SizedBox(height: 16.h),

        // Modern League Selection Grid
        SizedBox(
          height: 120.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 4.w),
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
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: 16.w),
                  width: 140.w,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : AppColors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: isSelected
                        ? null
                        : Border.all(
                            color: AppColors.grey200,
                            width: 2,
                          ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected
                            ? AppColors.gradientStart.withValues(alpha: 0.3)
                            : AppColors.shadow.withValues(alpha: 0.08),
                        blurRadius: isSelected ? 16 : 8,
                        offset: Offset(0, isSelected ? 8 : 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withValues(alpha: 0.2)
                                : AppColors.primaryLight.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            _getLeagueIcon(league.section),
                            size: 24.sp,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          league.title ?? 'Без названия',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (league.section != null) ...[
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withValues(alpha: 0.2)
                                  : AppColors.grey100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              league.section!.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 8.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? AppColors.white
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        SizedBox(height: 32.h),

        // Modern Data Tabs
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow.withValues(alpha: 0.1),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(child: _buildDataTab('Будущие', 0, Icons.schedule)),
              Expanded(child: _buildDataTab('Прошлые', 1, Icons.history)),
              Expanded(child: _buildDataTab('Игроки', 2, Icons.people)),
              Expanded(child: _buildDataTab('Тренеры', 3, Icons.sports)),
            ],
          ),
        ),

        SizedBox(height: 24.h),

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

  Widget _buildDataTab(String title, int index, IconData icon) {
    final isSelected = _dataTabController.index == index;

    return GestureDetector(
      onTap: () => _dataTabController.animateTo(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          gradient: isSelected ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? AppColors.white : AppColors.textSecondary,
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 10.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.white : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.grey100,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.sports_soccer,
              size: 48.sp,
              color: AppColors.textSecondary,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Нет доступных лиг',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Попробуйте обновить страницу',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getLeagueIcon(String? section) {
    switch (section?.toLowerCase()) {
      case 'men':
        return Icons.sports_soccer;
      case 'women':
        return Icons.sports_soccer;
      case 'futsal':
        return Icons.sports_handball;
      default:
        return Icons.shield;
    }
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
      return _buildEmptyContentState(
        isFuture ? 'Нет предстоящих матчей' : 'Нет прошедших матчей',
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    match.championship?.title ?? 'Турнир не указан',
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
                            width: 60.w,
                            height: 60.w,
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
                                match.team1?.image?.thumb ?? '',
                                fit: BoxFit.cover,
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
                          SizedBox(height: 12.h),
                          Text(
                            match.team1?.title ?? 'Команда 1',
                            style: TextStyle(
                              fontSize: 14.sp,
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
                      width: 120.w,
                      child: Column(
                        children: [
                          if (isFuture) ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.schedule,
                                    color: AppColors.white,
                                    size: 20.sp,
                                  ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    _formatDateTime(match.startedAt),
                                    style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ] else ...[
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20.w,
                                vertical: 16.h,
                              ),
                              decoration: BoxDecoration(
                                gradient: AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Text(
                                '${match.team1Score ?? 0} : ${match.team2Score ?? 0}',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.grey100,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              'ТУР ${match.tour}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Team 2
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60.w,
                            height: 60.w,
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
                                match.team2?.image?.thumb ?? '',
                                fit: BoxFit.cover,
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
                          SizedBox(height: 12.h),
                          Text(
                            match.team2?.title ?? 'Команда 2',
                            style: TextStyle(
                              fontSize: 14.sp,
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

  Widget _buildEmptyContentState(String message, IconData icon) {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
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

  Widget _buildPlayersList(dynamic players) {
    if (players.isEmpty) {
      return _buildEmptyContentState('Нет игроков', Icons.people);
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      itemCount: players.length,
      itemBuilder: (context, index) {
        final player = players[index];
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
            child: Row(
              children: [
                // Player Avatar
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: BorderRadius.circular(35.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gradientStart.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.r),
                      child: Image.network(
                        player.image?.thumb ?? '',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              color: AppColors.grey50,
                              borderRadius: BorderRadius.circular(32.r),
                            ),
                            child: Icon(
                              Icons.person,
                              size: 35.sp,
                              color: AppColors.textSecondary,
                            ),
                          );
                        },
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
                        '${player.firstName ?? ''} ${player.lastName ?? ''}'
                            .trim(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 6.h),

                      // Position Badge
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          player.line?.title ?? 'Позиция не указана',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Club
                      Row(
                        children: [
                          Icon(
                            Icons.business,
                            size: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              player.club ?? 'Клуб не указан',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Stats
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '${player.games ?? 0}',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          Text(
                            'игр',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (player.goals != null && player.goals > 0) ...[
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '⚽ ${player.goals}',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.success,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
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
      return _buildEmptyContentState('Нет тренеров', Icons.sports);
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
            child: Row(
              children: [
                // Coach Avatar with Special Border
                Container(
                  width: 70.w,
                  height: 70.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.warning.withValues(alpha: 0.8),
                        AppColors.warning,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(35.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.warning.withValues(alpha: 0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Container(
                    margin: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(32.r),
                      child: Image.network(
                        coach.image?.thumb ?? '',
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

                SizedBox(width: 16.w),

                // Coach Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name with Coach Icon
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${coach.firstName ?? ''} ${coach.lastName ?? ''}'
                                  .trim(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Icon(
                              Icons.sports,
                              size: 14.sp,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 8.h),

                      // Position/Title
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warning.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColors.warning.withValues(alpha: 0.3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          coach.title ?? 'Должность не указана',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.warning,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),

                      SizedBox(height: 8.h),

                      // Nationality
                      Row(
                        children: [
                          Icon(
                            Icons.flag,
                            size: 14.sp,
                            color: AppColors.textSecondary,
                          ),
                          SizedBox(width: 4.w),
                          Expanded(
                            child: Text(
                              coach.nationality ?? 'Национальность не указана',
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
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
                ),
              ],
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
