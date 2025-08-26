import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/standings/presentation/bloc/standing_event.dart';
import 'package:jankuier_mobile/features/standings/presentation/bloc/standing_state.dart';
import '../../domain/use_cases/get_matches_from_sota_case.dart';
import '../../domain/use_cases/get_standings_table_from_sota_case.dart';

class StandingBloc extends Bloc<StandingEvent, GetStandingState> {
  final GetStandingsTableFromSotaCase getStandingsTableFromSotaCase;
  final GetMatchesFromSotaCase getMatchesFromSotaCase;

  StandingBloc({
    required this.getStandingsTableFromSotaCase,
    required this.getMatchesFromSotaCase,
  }) : super(GetStandingStateInitialState()) {
    on<LoadStandingsTableFromSotaEvent>(_onLoadStandingsTable);
    on<LoadMatchesFromSotaEvent>(_onLoadMatches);
  }

  Future<void> _onLoadStandingsTable(
    LoadStandingsTableFromSotaEvent event,
    Emitter<GetStandingState> emit,
  ) async {
    emit(GetStandingsTableFromSotaLoadingState());

    final result = await getStandingsTableFromSotaCase();

    result.fold(
      (failure) => emit(GetStandingsTableFromSotaFailedState(failure)),
      (data) => emit(GetStandingsTableFromSotaLoadedState(data)),
    );
  }

  Future<void> _onLoadMatches(
    LoadMatchesFromSotaEvent event,
    Emitter<GetStandingState> emit,
  ) async {
    emit(GetMatchesFromSotaLoadingState());

    final result = await getMatchesFromSotaCase(event.parameter);

    result.fold(
      (failure) => emit(GetMatchesFromSotaFailedState(failure)),
      (data) => emit(GetMatchesFromSotaLoadedState(data)),
    );
  }
}
