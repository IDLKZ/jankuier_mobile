import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_future_matches_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_state.dart';

@injectable
class GetFutureMatchesBloc extends Bloc<GetFutureMatchesEvent, GetFutureMatchesState> {
  final GetFutureMatchesCase getFutureMatchesCase;

  GetFutureMatchesBloc({required this.getFutureMatchesCase})
      : super(GetFutureMatchesInitialState()) {
    on<GetFutureMatchesRequestEvent>(_onGetFutureMatches);
  }

  Future<void> _onGetFutureMatches(
    GetFutureMatchesRequestEvent event,
    Emitter<GetFutureMatchesState> emit,
  ) async {
    emit(GetFutureMatchesLoadingState());

    final result = await getFutureMatchesCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetFutureMatchesFailedState(failure)),
      (matches) => emit(GetFutureMatchesSuccessState(matches)),
    );
  }
}