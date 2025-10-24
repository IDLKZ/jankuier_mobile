import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/standings/data/entities/match_entity.dart';

import '../../../../core/errors/failures.dart';
import '../../data/entities/score_table_team_entity.dart';

@immutable
abstract class GetStandingState extends Equatable {}

class GetStandingStateInitialState extends GetStandingState {
  @override
  List<Object?> get props => [];
}

//Загрузка Турнирной таблицы
class GetStandingsTableFromSotaLoadingState extends GetStandingState {
  @override
  List<Object?> get props => [];
}

//Загрузка Матчей
class GetMatchesFromSotaLoadingState extends GetStandingState {
  @override
  List<Object?> get props => [];
}

//Ошибка Загрузки Турнирной таблицы
class GetStandingsTableFromSotaFailedState extends GetStandingState {
  final Failure failureData;
  GetStandingsTableFromSotaFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

//Ошибка Загрузка Матчей
class GetMatchesFromSotaFailedState extends GetStandingState {
  final Failure failureData;
  GetMatchesFromSotaFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

//Успешная Загрузки Турнирной таблицы
class GetStandingsTableFromSotaLoadedState extends GetStandingState {
  final List<ScoreTableTeamEntity> result;
  GetStandingsTableFromSotaLoadedState(this.result);
  @override
  List<Object?> get props => [result];
}

//Успешная Загрузка Матчей
class GetMatchesFromSotaLoadedState extends GetStandingState {
  final List<MatchEntity> result;
  GetMatchesFromSotaLoadedState(this.result);
  @override
  List<Object?> get props => [result];
}

//Комбинированный state с таблицей и матчами
class GetStandingsAndMatchesLoadedState extends GetStandingState {
  final List<ScoreTableTeamEntity> standings;
  final List<MatchEntity> matches;

  GetStandingsAndMatchesLoadedState({
    required this.standings,
    required this.matches,
  });

  @override
  List<Object?> get props => [standings, matches];
}
