import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_future_matches_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_state.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/content_refresh_service.dart';

@injectable
class GetFutureMatchesBloc extends Bloc<GetFutureMatchesEvent, GetFutureMatchesState> {
  final GetFutureMatchesCase getFutureMatchesCase;
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;
  int? _lastLeagueId;

  GetFutureMatchesBloc({required this.getFutureMatchesCase})
      : super(GetFutureMatchesInitialState()) {
    on<GetFutureMatchesRequestEvent>(_onGetFutureMatches);
    on<RefreshFutureMatchesContentEvent>(_onRefreshFutureMatchesContent);

    _initLanguageRefresh();
  }

  void _initLanguageRefresh() async {
    try {
      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          add(RefreshFutureMatchesContentEvent());
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
    }
  }

  Future<void> _onGetFutureMatches(
    GetFutureMatchesRequestEvent event,
    Emitter<GetFutureMatchesState> emit,
  ) async {
    emit(GetFutureMatchesLoadingState());
    _lastLeagueId = event.leagueId;

    final result = await getFutureMatchesCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetFutureMatchesFailedState(failure)),
      (matches) => emit(GetFutureMatchesSuccessState(matches)),
    );
  }

  Future<void> _onRefreshFutureMatchesContent(
    RefreshFutureMatchesContentEvent event,
    Emitter<GetFutureMatchesState> emit,
  ) async {
    final currentState = state;
    if (currentState is GetFutureMatchesSuccessState && _lastLeagueId != null) {
      emit(GetFutureMatchesLoadingState());
      add(GetFutureMatchesRequestEvent(_lastLeagueId!));
    }
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}