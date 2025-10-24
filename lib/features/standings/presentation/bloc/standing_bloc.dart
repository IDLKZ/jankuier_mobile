import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/standings/presentation/bloc/standing_event.dart';
import 'package:jankuier_mobile/features/standings/presentation/bloc/standing_state.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/services/content_refresh_service.dart';
import '../../data/entities/score_table_team_entity.dart';
import '../../domain/use_cases/get_matches_from_sota_case.dart';
import '../../domain/use_cases/get_standings_table_from_sota_case.dart';
import '../../domain/parameters/match_parameter.dart';

class StandingBloc extends Bloc<StandingEvent, GetStandingState> {
  final GetStandingsTableFromSotaCase getStandingsTableFromSotaCase;
  final GetMatchesFromSotaCase getMatchesFromSotaCase;
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;

  // Хранение загруженной таблицы для использования с матчами
  List<ScoreTableTeamEntity>? _cachedStandings;

  StandingBloc({
    required this.getStandingsTableFromSotaCase,
    required this.getMatchesFromSotaCase,
  }) : super(GetStandingStateInitialState()) {
    on<LoadStandingsTableFromSotaEvent>(_onLoadStandingsTable);
    on<LoadMatchesFromSotaEvent>(_onLoadMatches);
    on<RefreshStandingsContentEvent>(_onRefreshStandingsContent);

    _initLanguageRefresh();
  }

  void _initLanguageRefresh() async {
    try {
      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          add(const RefreshStandingsContentEvent());
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
    }
  }

  Future<void> _onLoadStandingsTable(
    LoadStandingsTableFromSotaEvent event,
    Emitter<GetStandingState> emit,
  ) async {
    emit(GetStandingsTableFromSotaLoadingState());

    final result = await getStandingsTableFromSotaCase();

    result.fold(
      (failure) => emit(GetStandingsTableFromSotaFailedState(failure)),
      (data) {
        _cachedStandings = data; // Сохраняем таблицу в кэш
        emit(GetStandingsTableFromSotaLoadedState(data));
      },
    );
  }

  Future<void> _onLoadMatches(
    LoadMatchesFromSotaEvent event,
    Emitter<GetStandingState> emit,
  ) async {
    emit(GetMatchesFromSotaLoadingState());

    // Загружаем таблицу, если она еще не загружена
    if (_cachedStandings == null) {
      final standingsResult = await getStandingsTableFromSotaCase();
      standingsResult.fold(
        (failure) {}, // Игнорируем ошибку загрузки таблицы
        (data) => _cachedStandings = data,
      );
    }

    final result = await getMatchesFromSotaCase(event.parameter);

    result.fold(
      (failure) => emit(GetMatchesFromSotaFailedState(failure)),
      (matches) {
        // Если есть кэшированная таблица, эмитим комбинированный state
        if (_cachedStandings != null) {
          emit(GetStandingsAndMatchesLoadedState(
            standings: _cachedStandings!,
            matches: matches,
          ));
        } else {
          // Иначе просто матчи
          emit(GetMatchesFromSotaLoadedState(matches));
        }
      },
    );
  }

  Future<void> _onRefreshStandingsContent(
    RefreshStandingsContentEvent event,
    Emitter<GetStandingState> emit,
  ) async {
    final currentState = state;

    // Обновляем турнирную таблицу
    add(LoadStandingsTableFromSotaEvent());

    // Если ранее были загружены матчи, обновим их с базовыми параметрами
    if (currentState is GetMatchesFromSotaLoadedState) {
      const defaultMatchParameter = MatchParameter();
      add(const LoadMatchesFromSotaEvent(defaultMatchParameter));
    }
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}
