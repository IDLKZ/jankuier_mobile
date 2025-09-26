import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_coaches_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_state.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/content_refresh_service.dart';

@injectable
class GetCoachesBloc extends Bloc<GetCoachesEvent, GetCoachesState> {
  final GetCoachesCase getCoachesCase;
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;
  int? _lastLeagueId;

  GetCoachesBloc({required this.getCoachesCase})
      : super(GetCoachesInitialState()) {
    on<GetCoachesRequestEvent>(_onGetCoaches);
    on<RefreshCoachesContentEvent>(_onRefreshCoachesContent);

    _initLanguageRefresh();
  }

  void _initLanguageRefresh() async {
    try {
      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          add(RefreshCoachesContentEvent());
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
    }
  }

  Future<void> _onGetCoaches(
    GetCoachesRequestEvent event,
    Emitter<GetCoachesState> emit,
  ) async {
    emit(GetCoachesLoadingState());
    _lastLeagueId = event.leagueId;

    final result = await getCoachesCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetCoachesFailedState(failure)),
      (coaches) => emit(GetCoachesSuccessState(coaches)),
    );
  }

  Future<void> _onRefreshCoachesContent(
    RefreshCoachesContentEvent event,
    Emitter<GetCoachesState> emit,
  ) async {
    final currentState = state;
    if (currentState is GetCoachesSuccessState && _lastLeagueId != null) {
      emit(GetCoachesLoadingState());
      add(GetCoachesRequestEvent(_lastLeagueId!));
    }
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}