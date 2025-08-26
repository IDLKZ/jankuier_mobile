import 'package:equatable/equatable.dart';

class PlayerStatsEntity extends Equatable {
  final int shot;
  final int shotsOnGoal;
  final int shotsOffGoal;
  final int foul;
  final int yellowCards;
  final int redCards;
  final int pass;
  final int offside;
  final int corner;
  final int duel;
  final int tackle;

  const PlayerStatsEntity({
    required this.shot,
    required this.shotsOnGoal,
    required this.shotsOffGoal,
    required this.foul,
    required this.yellowCards,
    required this.redCards,
    required this.pass,
    required this.offside,
    required this.corner,
    required this.duel,
    required this.tackle,
  });

  factory PlayerStatsEntity.fromJson(Map<String, dynamic> json) {
    return PlayerStatsEntity(
      shot: json['shot'] ?? 0,
      shotsOnGoal: json['shots_on_goal'] ?? 0,
      shotsOffGoal: json['shots_off_goal'] ?? 0,
      foul: json['foul'] ?? 0,
      yellowCards: json['yellow_cards'] ?? 0,
      redCards: json['red_cards'] ?? 0,
      pass: json['pass'] ?? 0,
      offside: json['offside'] ?? 0,
      corner: json['corner'] ?? 0,
      duel: json['duel'] ?? 0,
      tackle: json['tackle'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shot': shot,
      'shots_on_goal': shotsOnGoal,
      'shots_off_goal': shotsOffGoal,
      'foul': foul,
      'yellow_cards': yellowCards,
      'red_cards': redCards,
      'pass': pass,
      'offside': offside,
      'corner': corner,
      'duel': duel,
      'tackle': tackle,
    };
  }

  @override
  List<Object?> get props => [
        shot,
        shotsOnGoal,
        shotsOffGoal,
        foul,
        yellowCards,
        redCards,
        pass,
        offside,
        corner,
        duel,
        tackle,
      ];
}

class PlayerEntity extends Equatable {
  final String id;
  final String team;
  final int number;
  final String firstName;
  final String lastName;
  final PlayerStatsEntity stats;

  const PlayerEntity({
    required this.id,
    required this.team,
    required this.number,
    required this.firstName,
    required this.lastName,
    required this.stats,
  });

  factory PlayerEntity.fromJson(Map<String, dynamic> json) {
    return PlayerEntity(
      id: json['id'] ?? '',
      team: json['team'] ?? '',
      number: json['number'] ?? 0,
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      stats: PlayerStatsEntity.fromJson(json['stats'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team': team,
      'number': number,
      'first_name': firstName,
      'last_name': lastName,
      'stats': stats.toJson(),
    };
  }

  String get fullName => '$firstName $lastName';

  @override
  List<Object?> get props => [id, team, number, firstName, lastName, stats];
}

class PlayersStatsDataEntity extends Equatable {
  final String? latestUpdateDateTime;
  final List<PlayerEntity> players;

  const PlayersStatsDataEntity({
    this.latestUpdateDateTime,
    required this.players,
  });

  factory PlayersStatsDataEntity.fromJson(Map<String, dynamic> json) {
    return PlayersStatsDataEntity(
      latestUpdateDateTime: json['latest_update_date_time'],
      players: (json['players'] as List<dynamic>)
          .map((playerJson) => PlayerEntity.fromJson(playerJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latest_update_date_time': latestUpdateDateTime,
      'players': players.map((player) => player.toJson()).toList(),
    };
  }

  // Helper methods to filter players by team
  List<PlayerEntity> getPlayersByTeam(String teamName) {
    return players.where((player) => player.team == teamName).toList();
  }

  // Helper method to get all unique team names
  List<String> get teamNames {
    return players.map((player) => player.team).toSet().toList();
  }

  @override
  List<Object?> get props => [latestUpdateDateTime, players];
}

class PlayersStatsResponseEntity extends Equatable {
  final String result;
  final PlayersStatsDataEntity data;

  const PlayersStatsResponseEntity({
    required this.result,
    required this.data,
  });

  factory PlayersStatsResponseEntity.fromJson(Map<String, dynamic> json) {
    return PlayersStatsResponseEntity(
      result: json['result'],
      data: PlayersStatsDataEntity.fromJson(json['data']),
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
