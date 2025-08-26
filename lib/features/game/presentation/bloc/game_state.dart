import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/errors/failures.dart';
import '../../data/entities/match_lineup_entity.dart';
import '../../data/entities/player_stat_entity.dart';
import '../../data/entities/team_stat_entity.dart';

@immutable
abstract class GetGameState extends Equatable {}

class GetGameStateInitialState extends GetGameState {
  @override
  List<Object?> get props => [];
}

//Загрузка Статистики Команды
class GetTeamStatsByGameIdLoadingState extends GetGameState {
  @override
  List<Object?> get props => [];
}

//Загрузка Статистики Игроков
class GetPlayerStatsByGameIdLoadingState extends GetGameState {
  @override
  List<Object?> get props => [];
}

//Загрузка Статистики Прематча
class GetMatchLineUpStatsByGameIdLoadingState extends GetGameState {
  @override
  List<Object?> get props => [];
}

//Ошибка Статистики Команды
class GetTeamStatsByGameIdFailedState extends GetGameState {
  final Failure failureData;
  GetTeamStatsByGameIdFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

//Ошибка Статистики Игроков
class GetPlayerStatsByGameIdFailedState extends GetGameState {
  final Failure failureData;
  GetPlayerStatsByGameIdFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

//Ошибка Статистики Прематча
class GetMatchLineUpStatsByGameIdFailedState extends GetGameState {
  final Failure failureData;
  GetMatchLineUpStatsByGameIdFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

//Успешная Статистики Команды
class GetTeamStatsByGameIdLoadedState extends GetGameState {
  final TeamsStatsResponseEntity result;
  GetTeamStatsByGameIdLoadedState(this.result);
  @override
  List<Object?> get props => [result];
}

//Успешная Статистики Игроков
class GetPlayerStatsByGameIdLoadedState extends GetGameState {
  final PlayersStatsResponseEntity result;
  GetPlayerStatsByGameIdLoadedState(this.result);
  @override
  List<Object?> get props => [result];
}

//Успешная Статистики Прематча
class GetMatchLineUpStatsByGameIdLoadedState extends GetGameState {
  final MatchLineupEntity result;
  GetMatchLineUpStatsByGameIdLoadedState(this.result);
  @override
  List<Object?> get props => [result];
}
