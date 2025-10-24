import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/constants/ticketon_api_constants.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_event.dart';
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_state.dart';
import '../../../domain/use_cases/get_ticketon_shows_use_case.dart';
import '../../../domain/parameters/ticketon_get_shows_parameter.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/services/content_refresh_service.dart';

@injectable
class TicketonShowsBloc extends Bloc<TicketonShowsEvent, TicketonShowsState> {
  final GetTicketonShowsUseCase getTicketonShowsShowsUseCase;
  StreamSubscription? _languageSubscription;
  ContentRefreshService? _contentRefreshService;

  TicketonShowsBloc({required this.getTicketonShowsShowsUseCase})
      : super(const TicketonShowsInitial()) {
    on<LoadTicketonShowsEvent>(_onLoadTicketonShowsShows);
    on<RefreshTicketonShowsContentEvent>(_onRefreshTicketonShowsContent);

    _initLanguageRefresh();
  }

  void _initLanguageRefresh() async {
    try {
      // Добавляем небольшую задержку чтобы убедиться что все сервисы инициализированы
      await Future.delayed(const Duration(milliseconds: 100));

      _contentRefreshService = await getIt.getAsync<ContentRefreshService>();
      _languageSubscription = _contentRefreshService!.onLanguageChanged.listen(
        (newLanguage) {
          if (!isClosed) {
            add(RefreshTicketonShowsContentEvent());
          }
        },
      );
    } catch (e) {
      // Service not available, continue without language refresh
      print('TicketonShowsBloc: ContentRefreshService not available: $e');
    }
  }

  Future<void> _onLoadTicketonShowsShows(
    LoadTicketonShowsEvent event,
    Emitter<TicketonShowsState> emit,
  ) async {
    emit(const TicketonShowsLoading());

    final result = await getTicketonShowsShowsUseCase(event.parameter);

    result.fold(
      (failure) => emit(TicketonShowsError(message: failure.message ?? "")),
      (shows) => emit(TicketonShowsShowsLoaded(shows: shows)),
    );
  }

  Future<void> _onRefreshTicketonShowsContent(
    RefreshTicketonShowsContentEvent event,
    Emitter<TicketonShowsState> emit,
  ) async {
    final currentState = state;
    if (currentState is TicketonShowsShowsLoaded) {
      emit(const TicketonShowsLoading());

      // Используем базовые параметры с текущим языком
      final parameter = TicketonGetShowsParameter.withCurrentLocale();
      add(LoadTicketonShowsEvent(parameter: parameter));
    }
  }

  @override
  Future<void> close() {
    _languageSubscription?.cancel();
    return super.close();
  }
}
