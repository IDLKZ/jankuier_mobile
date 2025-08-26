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

class ScoreTableTeamListEntity {
  static List<ScoreTableTeamEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ScoreTableTeamEntity.fromJson(json)).toList();
  }
}
