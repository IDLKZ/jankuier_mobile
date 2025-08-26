import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jankuier_mobile/features/game/domain/use_cases/get_match_line_up_stats_by_game_id_case.dart';
import 'package:jankuier_mobile/features/game/domain/use_cases/get_player_stats_by_game_id_case.dart';
import '../../domain/use_cases/get_team_stats_by_game_id_case.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GetGameState> {
  final GetTeamStatsByGameIdCase getTeamStatsByGameIdCase;
  final GetPlayerStatsByGameIdCase getPlayerStatsByGameIdCase;
  final GetMatchLineUpStatsByGameIdCase getMatchLineUpStatsByGameIdCase;

  GameBloc({
    required this.getTeamStatsByGameIdCase,
    required this.getPlayerStatsByGameIdCase,
    required this.getMatchLineUpStatsByGameIdCase,
  }) : super(GetGameStateInitialState()) {
    on<GetTeamStatsByGameIdEvent>(_onGetTeamStatsByGameId);
    on<GetPlayerStatsByGameIdEvent>(_onGetPlayerStatsByGameId);
    on<GetMatchLineUpStatsByGameIdEvent>(_onGetMatchLineUpStatsByGameId);
  }

  Future<void> _onGetTeamStatsByGameId(
    GetTeamStatsByGameIdEvent event,
    Emitter<GetGameState> emit,
  ) async {
    emit(GetTeamStatsByGameIdLoadingState());

    final result = await getTeamStatsByGameIdCase(event.gameId);

    result.fold(
      (failure) => emit(GetTeamStatsByGameIdFailedState(failure)),
      (data) => emit(GetTeamStatsByGameIdLoadedState(data)),
    );
  }

  Future<void> _onGetPlayerStatsByGameId(
    GetPlayerStatsByGameIdEvent event,
    Emitter<GetGameState> emit,
  ) async {
    emit(GetPlayerStatsByGameIdLoadingState());

    final result = await getPlayerStatsByGameIdCase(event.gameId);

    result.fold(
      (failure) => emit(GetPlayerStatsByGameIdFailedState(failure)),
      (data) => emit(GetPlayerStatsByGameIdLoadedState(data)),
    );
  }

  Future<void> _onGetMatchLineUpStatsByGameId(
    GetMatchLineUpStatsByGameIdEvent event,
    Emitter<GetGameState> emit,
  ) async {
    emit(GetMatchLineUpStatsByGameIdLoadingState());

    final result = await getMatchLineUpStatsByGameIdCase(event.gameId);

    result.fold(
      (failure) => emit(GetMatchLineUpStatsByGameIdFailedState(failure)),
      (data) => emit(GetMatchLineUpStatsByGameIdLoadedState(data)),
    );
  }
}
