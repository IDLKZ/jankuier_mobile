import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../data/entities/news_entity.dart';
import '../../../data/entities/news_response.dart';
import '../../../domain/use_cases/get_new_one_use_cases.dart';
import '../get_single_new/get_new_event.dart';
import '../get_single_new/get_new_state.dart';

@injectable
class GetNewOneBloc extends Bloc<GetNewOneBaseEvent, GetNewOneStateState> {
  GetNewOneBloc({
    required GetNewOneFromKffCase GetNewOneFromKffCase,
    required GetNewOneFromKffLeagueCase GetNewOneFromKffLeagueCase,
  })  : _GetNewOneFromKffCase = GetNewOneFromKffCase,
        _GetNewOneFromKffLeagueCase = GetNewOneFromKffLeagueCase,
        super(GetNewOneStateInitialState()) {
    on<GetNewOneFromKffEvent>(_handleGetNewOneFromKffEvent);
    on<GetNewOneFromKffLeagueEvent>(_handleGetNewOneFromKffLeagueEvent);
  }

  final GetNewOneFromKffCase _GetNewOneFromKffCase;
  final GetNewOneFromKffLeagueCase _GetNewOneFromKffLeagueCase;

  Future<void> _handleGetNewOneFromKffEvent(
      GetNewOneFromKffEvent event,
      Emitter<GetNewOneStateState> emit,
      ) async {
    emit(GetNewOneStateLoadingState());

    final result = await _GetNewOneFromKffCase(event.parameter);

    result.fold(
      (failure) => emit(GetNewOneStateFailedState(failure)),
      (newsResponse) => emit(GetNewOneStateSuccessState(newsResponse)),
    );
  }

  Future<void> _handleGetNewOneFromKffLeagueEvent(
      GetNewOneFromKffLeagueEvent event,
      Emitter<GetNewOneStateState> emit,
      ) async {
    emit(GetNewOneStateLoadingState());

    final result = await _GetNewOneFromKffLeagueCase(event.parameter);

    result.fold(
      (failure) => emit(GetNewOneStateFailedState(failure)),
      (newsResponse) => emit(GetNewOneStateSuccessState(newsResponse)),
    );
  }

}
