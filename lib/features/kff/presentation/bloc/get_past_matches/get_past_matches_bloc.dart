import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_past_matches_case.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_event.dart';
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_state.dart';

@injectable
class GetPastMatchesBloc extends Bloc<GetPastMatchesEvent, GetPastMatchesState> {
  final GetPastMatchesCase getPastMatchesCase;

  GetPastMatchesBloc({required this.getPastMatchesCase})
      : super(GetPastMatchesInitialState()) {
    on<GetPastMatchesRequestEvent>(_onGetPastMatches);
  }

  Future<void> _onGetPastMatches(
    GetPastMatchesRequestEvent event,
    Emitter<GetPastMatchesState> emit,
  ) async {
    emit(GetPastMatchesLoadingState());

    final result = await getPastMatchesCase.call(event.leagueId);

    result.fold(
      (failure) => emit(GetPastMatchesFailedState(failure)),
      (matches) => emit(GetPastMatchesSuccessState(matches)),
    );
  }
}