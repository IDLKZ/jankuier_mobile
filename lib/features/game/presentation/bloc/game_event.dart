import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class GetTeamStatsByGameIdEvent extends GameEvent {
  final String gameId;
  const GetTeamStatsByGameIdEvent(this.gameId);
  @override
  List<Object?> get props => [gameId];
}

class GetPlayerStatsByGameIdEvent extends GameEvent {
  final String gameId;
  const GetPlayerStatsByGameIdEvent(this.gameId);
  @override
  List<Object?> get props => [gameId];
}

class GetMatchLineUpStatsByGameIdEvent extends GameEvent {
  final String gameId;
  const GetMatchLineUpStatsByGameIdEvent(this.gameId);
  @override
  List<Object?> get props => [gameId];
}
