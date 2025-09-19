import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/entities/news_entity.dart';
import '../../../data/entities/news_response.dart';
import '../../../domain/use_cases/get_news_use_cases.dart';
import 'get_news_event.dart';
import 'get_news_state.dart';

@injectable
class GetNewsBloc extends Bloc<GetNewsBaseEvent, GetNewsStateState> {
  GetNewsBloc({
    required GetNewsFromKffCase getNewsFromKffCase,
    required GetNewsFromKffLeagueCase getNewsFromKffLeagueCase,
  })  : _getNewsFromKffCase = getNewsFromKffCase,
        _getNewsFromKffLeagueCase = getNewsFromKffLeagueCase,
        super(GetNewsStateInitialState()) {
    on<GetNewsFromKffEvent>(_handleGetNewsFromKffEvent);
    on<GetNewsFromKffLeagueEvent>(_handleGetNewsFromKffLeagueEvent);
    on<LoadMoreNewsFromKffEvent>(_handleLoadMoreNewsFromKffEvent);
    on<LoadMoreNewsFromKffLeagueEvent>(_handleLoadMoreNewsFromKffLeagueEvent);
  }

  final GetNewsFromKffCase _getNewsFromKffCase;
  final GetNewsFromKffLeagueCase _getNewsFromKffLeagueCase;

  Future<void> _handleGetNewsFromKffEvent(
      GetNewsFromKffEvent event,
      Emitter<GetNewsStateState> emit,
      ) async {
    emit(GetNewsStateLoadingState());

    final result = await _getNewsFromKffCase(event.parameter);
    result.fold(
          (failure) => emit(GetNewsStateFailedState(failure)),
          (success) => emit(GetNewsStateSuccessState(success)),
    );
  }

  Future<void> _handleGetNewsFromKffLeagueEvent(
      GetNewsFromKffLeagueEvent event,
      Emitter<GetNewsStateState> emit,
      ) async {
    emit(GetNewsStateLoadingState());

    final result = await _getNewsFromKffLeagueCase(event.parameter);
    result.fold(
          (failure) => emit(GetNewsStateFailedState(failure)),
          (success) => emit(GetNewsStateSuccessState(success)),
    );
  }

  Future<void> _handleLoadMoreNewsFromKffEvent(
    LoadMoreNewsFromKffEvent event,
    Emitter<GetNewsStateState> emit,
  ) async {
    final currentState = state;
    if (currentState is! GetNewsStateSuccessState || currentState.hasReachedMax) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await _getNewsFromKffCase(event.parameter);
    result.fold(
      (failure) => emit(GetNewsStateFailedState(failure)),
      (success) {
        final allNews = List<News>.from(currentState.newsResponse.data)
          ..addAll(success.data);

        final updatedResponse = NewsListResponse(
          success: success.success,
          code: success.code,
          data: allNews,
          meta: success.meta,
        );

        emit(GetNewsStateSuccessState(
          updatedResponse,
          hasReachedMax: success.data.isEmpty || success.data.length < event.parameter.perPage,
          isLoadingMore: false,
        ));
      },
    );
  }

  Future<void> _handleLoadMoreNewsFromKffLeagueEvent(
    LoadMoreNewsFromKffLeagueEvent event,
    Emitter<GetNewsStateState> emit,
  ) async {
    final currentState = state;
    if (currentState is! GetNewsStateSuccessState || currentState.hasReachedMax) {
      return;
    }

    emit(currentState.copyWith(isLoadingMore: true));

    final result = await _getNewsFromKffLeagueCase(event.parameter);
    result.fold(
      (failure) => emit(GetNewsStateFailedState(failure)),
      (success) {
        final allNews = List<News>.from(currentState.newsResponse.data)
          ..addAll(success.data);

        final updatedResponse = NewsListResponse(
          success: success.success,
          code: success.code,
          data: allNews,
          meta: success.meta,
        );

        emit(GetNewsStateSuccessState(
          updatedResponse,
          hasReachedMax: success.data.isEmpty || success.data.length < event.parameter.perPage,
          isLoadingMore: false,
        ));
      },
    );
  }
}
