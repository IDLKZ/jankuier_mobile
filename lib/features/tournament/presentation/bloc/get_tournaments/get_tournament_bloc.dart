import 'package:bloc/bloc.dart';
import '../../../domain/use_cases/get_tournaments_from_sota_case.dart';
import 'get_tournament_event.dart';
import 'get_tournament_state.dart';

class GetTournamentBloc
    extends Bloc<GetTournamentBaseEvent, GetTournamentStateState> {
  GetTournamentBloc(
      {required GetTournamentsFromSotaCase getTournamentsFromSotaCase})
      : _getTournamentsFromSotaCase = getTournamentsFromSotaCase,
        super(GetTournamentStateInitialState()) {
    on<GetTournamentEvent>(_handleGetTournamentEvent);
  }
  final GetTournamentsFromSotaCase _getTournamentsFromSotaCase;

  Future<void> _handleGetTournamentEvent(
      GetTournamentEvent event, Emitter<GetTournamentStateState> state) async {
    final result = await _getTournamentsFromSotaCase(event.parameter);
    result.fold((failure) => emit(GetTournamentStateFailedState(failure)),
        (success) => emit(GetTournamentStateSuccessState(success)));
  }
}
