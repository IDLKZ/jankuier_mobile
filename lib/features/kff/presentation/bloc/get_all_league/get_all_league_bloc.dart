import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_all_league_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_state.dart';

import '../../../../../core/di/injection.dart';
import '../../../../../core/services/content_refresh_service.dart';

@injectable
class GetAllLeagueBloc extends Bloc<GetAllLeagueEvent, GetAllLeagueState> {
  final GetAllLeagueCase getAllLeagueCase;
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;

  GetAllLeagueBloc({required this.getAllLeagueCase})
      : super(GetAllLeagueInitialState()) {
    on<GetAllLeagueRequestEvent>(_onGetAllLeague);
    on<RefreshAllLeagueContentEvent>(_onRefreshAllLeagueContent);

    _initLanguageRefresh();
  }

  void _initLanguageRefresh() async {
    try {
      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          add(RefreshAllLeagueContentEvent());
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
    }
  }

  Future<void> _onGetAllLeague(
    GetAllLeagueRequestEvent event,
    Emitter<GetAllLeagueState> emit,
  ) async {
    emit(GetAllLeagueLoadingState());

    final result = await getAllLeagueCase.call();

    result.fold(
      (failure) => emit(GetAllLeagueFailedState(failure)),
      (leagues) => emit(GetAllLeagueSuccessState(leagues)),
    );
  }

  Future<void> _onRefreshAllLeagueContent(
    RefreshAllLeagueContentEvent event,
    Emitter<GetAllLeagueState> emit,
  ) async {
    final currentState = state;
    if (currentState is GetAllLeagueSuccessState) {
      emit(GetAllLeagueLoadingState());
      add(GetAllLeagueRequestEvent());
    }
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}