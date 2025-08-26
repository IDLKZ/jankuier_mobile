import 'package:equatable/equatable.dart';

class TeamStatsEntity extends Equatable {
  final double possession;
  final int shot;
  final int shotsOnGoal;
  final int shotsOffGoal;
  final int foul;
  final int yellowCards;
  final int redCards;
  final int pass;
  final int offside;
  final int corner;

  const TeamStatsEntity({
    required this.possession,
    required this.shot,
    required this.shotsOnGoal,
    required this.shotsOffGoal,
    required this.foul,
    required this.yellowCards,
    required this.redCards,
    required this.pass,
    required this.offside,
    required this.corner,
  });

  factory TeamStatsEntity.fromJson(Map<String, dynamic> json) {
    return TeamStatsEntity(
      possession: json['possession'] != null ? (json['possession'] as num).toDouble() : 0.0,
      shot: json['shot'] ?? 0,
      shotsOnGoal: json['shots_on_goal'] ?? 0,
      shotsOffGoal: json['shots_off_goal'] ?? 0,
      foul: json['foul'] ?? 0,
      yellowCards: json['yellow_cards'] ?? 0,
      redCards: json['red_cards'] ?? 0,
      pass: json['pass'] ?? 0,
      offside: json['offside'] ?? 0,
      corner: json['corner'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'possession': possession,
      'shot': shot,
      'shots_on_goal': shotsOnGoal,
      'shots_off_goal': shotsOffGoal,
      'foul': foul,
      'yellow_cards': yellowCards,
      'red_cards': redCards,
      'pass': pass,
      'offside': offside,
      'corner': corner,
    };
  }

  @override
  List<Object?> get props => [
        possession,
        shot,
        shotsOnGoal,
        shotsOffGoal,
        foul,
        yellowCards,
        redCards,
        pass,
        offside,
        corner,
      ];
}

class TeamWithStatsEntity extends Equatable {
  final int id;
  final String name;
  final TeamStatsEntity stats;

  const TeamWithStatsEntity({
    required this.id,
    required this.name,
    required this.stats,
  });

  factory TeamWithStatsEntity.fromJson(Map<String, dynamic> json) {
    return TeamWithStatsEntity(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      stats: TeamStatsEntity.fromJson(json['stats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'stats': stats.toJson(),
    };
  }

  @override
  List<Object?> get props => [id, name, stats];
}

class TeamsStatsDataEntity extends Equatable {
  final String? latestUpdateDateTime;
  final List<TeamWithStatsEntity> teams;

  const TeamsStatsDataEntity({
    this.latestUpdateDateTime,
    required this.teams,
  });

  factory TeamsStatsDataEntity.fromJson(Map<String, dynamic> json) {
    return TeamsStatsDataEntity(
      latestUpdateDateTime: json['latest_update_date_time'],
      teams: (json['teams'] as List<dynamic>)
          .map((teamJson) => TeamWithStatsEntity.fromJson(teamJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest_update_date_time': latestUpdateDateTime,
      'teams': teams.map((team) => team.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [latestUpdateDateTime, teams];
}

class TeamsStatsResponseEntity extends Equatable {
  final String result;
  final TeamsStatsDataEntity data;

  const TeamsStatsResponseEntity({
    required this.result,
    required this.data,
  });

  factory TeamsStatsResponseEntity.fromJson(Map<String, dynamic> json) {
    return TeamsStatsResponseEntity(
      result: json['result'],
      data: TeamsStatsDataEntity.fromJson(json['data']),
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
