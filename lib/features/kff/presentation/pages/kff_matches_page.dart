import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_event.dart';
import 'package:jankuier_mobile/l10n/app_localizations.dart';
import 'package:jankuier_mobile/shared/widgets/common_app_bars/pages_common_app_bar.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/di/injection.dart';
import '../bloc/get_all_league/get_all_league_state.dart';
import '../../data/entities/from_kff/kff_league_entity.dart';
import '../bloc/get_future_matches/get_future_matches_bloc.dart';
import '../bloc/get_future_matches/get_future_matches_event.dart';
import '../bloc/get_past_matches/get_past_matches_bloc.dart';
import '../bloc/get_past_matches/get_past_matches_event.dart';
import '../bloc/get_players/get_players_bloc.dart';
import '../bloc/get_players/get_players_event.dart';
import '../bloc/get_coaches/get_coaches_bloc.dart';
import '../bloc/get_coaches/get_coaches_event.dart';
import '../bloc/get_one_league/get_one_league_bloc.dart';
import '../bloc/get_one_league/get_one_league_event.dart';
import '../widgets/_build_tabs_header.dart';
import '../widgets/_build_tabs_data.dart';

/// KFF Matches Page - основная страница для отображения футбольных матчей КФФ
///
/// Эта страница предоставляет:
/// - Переключение между национальными командами и клубами
/// - Выбор лиги из доступного списка
/// - Просмотр будущих и прошедших матчей
/// - Информацию об игроках и тренерах выбранной лиги
class KffMatchesPage extends StatefulWidget {
  const KffMatchesPage({super.key});

  @override
  State<KffMatchesPage> createState() => _KffMatchesPageState();
}

class _KffMatchesPageState extends State<KffMatchesPage>
    with TickerProviderStateMixin {
  /// Контроллер для основных табов (Национальные/Клубы)
  late TabController _mainTabController;

  /// Контроллер для табов данных (Будущие/Прошлые/Игроки/Тренеры)
  late TabController _dataTabController;

  /// Индекс выбранной лиги в списке лиг
  int selectedLeagueIndex = 0;

  /// Инициализация состояния виджета
  /// Создаются контроллеры табов и устанавливаются слушатели
  @override
  void initState() {
    super.initState();
    // Инициализация контроллера основных табов (2 таба: Национальные, Клубы)
    _mainTabController = TabController(length: 2, vsync: this);
    // Инициализация контроллера табов данных (4 таба: Будущие, Прошлые, Игроки, Тренеры)
    _dataTabController = TabController(length: 4, vsync: this);
    // Добавление слушателей для отслеживания изменений табов
    _mainTabController.addListener(_onMainTabChanged);
    _dataTabController.addListener(_onDataTabChanged);
  }

  /// Освобождение ресурсов при уничтожении виджета
  @override
  void dispose() {
    // Освобождение контроллеров табов
    _mainTabController.dispose();
    _dataTabController.dispose();
    super.dispose();
  }

  /// Обработчик изменения основного таба (Национальные/Клубы)
  void _onMainTabChanged() {
    if (_mainTabController.indexIsChanging) return;
    setState(() {});
  }

  /// Обработчик изменения таба данных (Будущие/Прошлые/Игроки/Тренеры)
  void _onDataTabChanged() {
    if (_dataTabController.indexIsChanging) return;
    setState(() {});
  }

  /// Метод для обновления BLoC'ов при выборе новой лиги с корректным контекстом
  /// Параметр [context] - BuildContext с доступом к BLoC'ам
  /// Параметр [leagueId] - ID новой выбранной лиги
  /// Обновляет все BLoC'ы, которые зависят от выбранной лиги:
  /// - GetFutureMatchesBloc - для загрузки будущих матчей
  /// - GetPastMatchesBloc - для загрузки прошедших матчей
  /// - GetPlayersBloc - для загрузки игроков лиги
  /// - GetCoachesBloc - для загрузки тренеров лиги
  /// - GetOneLeagueBloc - для получения детальной информации о лиге
  void _updateBlocsWithNewLeagueInContext(BuildContext context, int leagueId) {
    // Обновляем все BLoC'ы, которым нужен leagueId
    context
        .read<GetFutureMatchesBloc>()
        .add(GetFutureMatchesRequestEvent(leagueId));
    context
        .read<GetPastMatchesBloc>()
        .add(GetPastMatchesRequestEvent(leagueId));
    context.read<GetPlayersBloc>().add(GetPlayersRequestEvent(leagueId));
    context.read<GetCoachesBloc>().add(GetCoachesRequestEvent(leagueId));
    context.read<GetOneLeagueBloc>().add(GetOneLeagueRequestEvent(leagueId));
  }

  /// Основной метод построения UI страницы
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PagesCommonAppBar(
          title: AppLocalizations.of(context)!.nationalTeamMatches,
          actionIcon: Icons.sports_soccer,
          leadingIcon: Icons.arrow_back_ios_new,
          onActionTap: () {}),
      // Оборачиваем все содержимое в SingleChildScrollView для возможности прокрутки
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Основное содержимое страницы
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  // Содержимое табов - ConstrainedBox для ограничения высоты в SingleChildScrollView
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height * 0.6,
                      maxHeight: MediaQuery.of(context).size.height * 0.8,
                    ),
                    child: MultiBlocProvider(
                      providers: [
                        // BLoC для получения списка всех лиг
                        BlocProvider<GetAllLeagueBloc>(
                          create: (BuildContext context) =>
                              getIt<GetAllLeagueBloc>()
                                ..add(GetAllLeagueRequestEvent()),
                        ),
                        // BLoC для загрузки будущих матчей выбранной лиги
                        BlocProvider<GetFutureMatchesBloc>(
                          create: (context) => getIt<GetFutureMatchesBloc>(),
                        ),
                        // BLoC для загрузки прошедших матчей выбранной лиги
                        BlocProvider<GetPastMatchesBloc>(
                          create: (context) => getIt<GetPastMatchesBloc>(),
                        ),
                        // BLoC для загрузки игроков выбранной лиги
                        BlocProvider<GetPlayersBloc>(
                          create: (context) => getIt<GetPlayersBloc>(),
                        ),
                        // BLoC для загрузки тренеров выбранной лиги
                        BlocProvider<GetCoachesBloc>(
                          create: (context) => getIt<GetCoachesBloc>(),
                        ),
                        // BLoC для получения детальной информации о выбранной лиге
                        BlocProvider<GetOneLeagueBloc>(
                          create: (context) => getIt<GetOneLeagueBloc>(),
                        ),
                      ],
                      // Используем Builder для получения нового BuildContext с доступом к BLoC'ам
                      child: Builder(
                        builder: (builderContext) =>
                            BlocConsumer<GetAllLeagueBloc, GetAllLeagueState>(
                          listener: (BuildContext context, state) {
                            // Когда лиги загружены, автоматически загружаем данные для первой лиги
                            if (state is GetAllLeagueSuccessState &&
                                state.leagues.isNotEmpty) {
                              final firstLeagueId = state.leagues[0].id;
                              _updateBlocsWithNewLeagueInContext(
                                  builderContext, firstLeagueId);
                            }
                          },
                          builder: (BuildContext context, state) {
                            if (state is GetAllLeagueLoadingState) {
                              return _buildLoadingState();
                            } else if (state is GetAllLeagueSuccessState) {
                              return _buildLeaguesListWithContext(
                                  state.leagues, builderContext);
                            } else if (state is GetAllLeagueFailedState) {
                              return _buildErrorState(
                                  state.failure.message ?? "-");
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Строит состояние загрузки с анимированным индикатором
  /// Отображается пока загружаются данные лиг
  Widget _buildLoadingState() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: const CircularProgressIndicator(
              color: AppColors.white,
              strokeWidth: 3,
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            AppLocalizations.of(context)!.loadingLeagues,
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

  /// Строит состояние ошибки с сообщением
  /// Параметр [message] - текст ошибки для отображения пользователю
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
            AppLocalizations.of(context)!.loadingError,
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

  /// Строит список лиг с возможностью выбора с корректным контекстом
  /// Параметр [leagues] - список доступных лиг для отображения
  /// Параметр [blocContext] - BuildContext с доступом к BLoC'ам
  /// Содержит горизонтальный список лиг и табы с данными выбранной лиги
  Widget _buildLeaguesListWithContext(
      List<KffLeagueEntity> leagues, BuildContext blocContext) {
    if (leagues.isEmpty) return _buildEmptyState();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            AppLocalizations.of(context)!.selectNationalTeam,
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
          height: 30.h,
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
                  // Вызываем события для обновления данных в других BLoC при выборе новой лиги
                  _updateBlocsWithNewLeagueInContext(
                      blocContext, leagues[index].id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: 8.w),
                  height: 30.h,
                  decoration: BoxDecoration(
                    gradient: isSelected ? AppColors.primaryGradient : null,
                    color: isSelected ? null : AppColors.white,
                    borderRadius: BorderRadius.circular(5.r),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          league.title ??
                              AppLocalizations.of(context)!.untitled,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected
                                ? AppColors.white
                                : AppColors.textPrimary,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (league.section != null) ...[
                          SizedBox(width: 4.w),
                          Text(
                            '(${league.section!.toUpperCase()})',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 8.sp,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.textSecondary,
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

        SizedBox(height: 12.h),

        // Modern Data Tabs
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          padding: EdgeInsets.all(6.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
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
                  child: buildDataTab(AppLocalizations.of(context)!.future, 0,
                      Icons.schedule, _dataTabController)),
              Expanded(
                  child: buildDataTab(AppLocalizations.of(context)!.past, 1,
                      Icons.history, _dataTabController)),
              Expanded(
                  child: buildDataTab(AppLocalizations.of(context)!.players, 2,
                      Icons.people, _dataTabController)),
              Expanded(
                  child: buildDataTab(AppLocalizations.of(context)!.coaches, 3,
                      Icons.sports, _dataTabController)),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Содержимое табов данных - BLoC'и уже доступны из верхнего уровня
        Expanded(
          child: TabBarView(
            controller: _dataTabController,
            children: [
              buildFutureMatchesTab(),
              buildPastMatchesTab(),
              buildPlayersTab(),
              buildCoachesTab(),
            ],
          ),
        ),
      ],
    );
  }

  /// Строит пустое состояние когда лиги недоступны
  /// Отображается когда список лиг пустой
  Widget _buildEmptyState() {
    return Container(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: const BoxDecoration(
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
            AppLocalizations.of(context)!.noAvailableLeagues,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppLocalizations.of(context)!.tryReloadPage,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
