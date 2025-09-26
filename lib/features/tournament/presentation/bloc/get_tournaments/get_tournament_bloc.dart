import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/content_refresh_service.dart';
import '../../../domain/use_cases/get_tournaments_from_sota_case.dart';
import '../../../domain/parameters/get_tournament_parameter.dart';
import 'get_tournament_event.dart';
import 'get_tournament_state.dart';

class GetTournamentBloc
    extends Bloc<GetTournamentBaseEvent, GetTournamentStateState> {
  GetTournamentBloc(
      {required GetTournamentsFromSotaCase getTournamentsFromSotaCase})
      : _getTournamentsFromSotaCase = getTournamentsFromSotaCase,
        super(GetTournamentStateInitialState()) {
    on<GetTournamentEvent>(_handleGetTournamentEvent);
    on<RefreshTournamentsContentEvent>(_handleRefreshTournamentsContentEvent);

    _initLanguageRefresh();
  }

  final GetTournamentsFromSotaCase _getTournamentsFromSotaCase;
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;

  void _initLanguageRefresh() async {
    try {
      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          add(RefreshTournamentsContentEvent());
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
    }
  }

  Future<void> _handleGetTournamentEvent(
      GetTournamentEvent event, Emitter<GetTournamentStateState> state) async {
    final result = await _getTournamentsFromSotaCase(event.parameter);
    result.fold((failure) => emit(GetTournamentStateFailedState(failure)),
        (success) => emit(GetTournamentStateSuccessState(success)));
  }

  Future<void> _handleRefreshTournamentsContentEvent(
    RefreshTournamentsContentEvent event,
    Emitter<GetTournamentStateState> emit,
  ) async {
    final currentState = state;
    if (currentState is GetTournamentStateSuccessState) {
      // Определяем последние использованные параметры и обновляем турниры
      emit(GetTournamentStateLoadingState());

      // Используем базовые параметры для обновления
      const defaultParameter = GetTournamentParameter(
        page: 1,
        pageSize: 50,
        country: 112, // Kazakhstan
      );

      add(GetTournamentEvent(defaultParameter));
    }
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}
