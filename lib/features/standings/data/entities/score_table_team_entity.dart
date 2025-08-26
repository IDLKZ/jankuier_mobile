import 'package:equatable/equatable.dart';

class ScoreTableTeamEntity extends Equatable {
  final int id;
  final String name;
  final String logo;
  final int rg;
  final int wins;
  final int draws;
  final int losses;
  final int points;
  final int matches;
  final String goals;

  const ScoreTableTeamEntity({
    required this.id,
    required this.name,
    required this.logo,
    required this.rg,
    required this.wins,
    required this.draws,
    required this.losses,
    required this.points,
    required this.matches,
    required this.goals,
  });

  factory ScoreTableTeamEntity.fromJson(Map<String, dynamic> json) {
    return ScoreTableTeamEntity(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      rg: json['rg'],
      wins: json['wins'],
      draws: json['draws'],
      losses: json['losses'],
      points: json['points'],
      matches: json['matches'],
      goals: json['goals'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'logo': logo,
      'rg': rg,
      'wins': wins,
      'draws': draws,
      'losses': losses,
      'points': points,
      'matches': matches,
      'goals': goals,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        logo,
        rg,
        wins,
        draws,
        losses,
        points,
        matches,
        goals,
      ];
}

class ScoreTableDataEntity extends Equatable {
  final String latestUpdateDateTime;
  final List<ScoreTableTeamEntity> table;

  const ScoreTableDataEntity({
    required this.latestUpdateDateTime,
    required this.table,
  });

  factory ScoreTableDataEntity.fromJson(Map<String, dynamic> json) {
    return ScoreTableDataEntity(
      latestUpdateDateTime: json['latest_update_date_time'],
      table: (json['table'] as List<dynamic>)
          .map((teamJson) => ScoreTableTeamEntity.fromJson(teamJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest_update_date_time': latestUpdateDateTime,
      'table': table.map((team) => team.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [latestUpdateDateTime, table];
}

class ScoreTableResponseEntity extends Equatable {
  final String result;
  final ScoreTableDataEntity data;

  const ScoreTableResponseEntity({
    required this.result,
    required this.data,
  });

  factory ScoreTableResponseEntity.fromJson(Map<String, dynamic> json) {
    return ScoreTableResponseEntity(
      result: json['result'],
      data: ScoreTableDataEntity.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'result': result,
      'data': data.toJson(),
    };
  }

  @override
  List<Object?> get props => [result, data];
}
