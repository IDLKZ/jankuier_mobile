import 'package:equatable/equatable.dart';

class TeamEntity extends Equatable {
  final int id;
  final String name;
  final int score;

  const TeamEntity({
    required this.id,
    required this.name,
    required this.score,
  });

  factory TeamEntity.fromJson(Map<String, dynamic> json) {
    return TeamEntity(
      id: json['id'],
      name: json['name'],
      score: json['score'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'score': score,
    };
  }

  @override
  List<Object?> get props => [id, name, score];
}

class MatchEntity extends Equatable {
  final String id;
  final String date;
  final int tournamentId;
  final TeamEntity homeTeam;
  final TeamEntity awayTeam;
  final int tour;
  final bool hasStats;
  final int seasonId;
  final String seasonName;
  final int visitors;

  const MatchEntity({
    required this.id,
    required this.date,
    required this.tournamentId,
    required this.homeTeam,
    required this.awayTeam,
    required this.tour,
    required this.hasStats,
    required this.seasonId,
    required this.seasonName,
    required this.visitors,
  });

  factory MatchEntity.fromJson(Map<String, dynamic> json) {
    return MatchEntity(
      id: json['id'],
      date: json['date'],
      tournamentId: json['tournament_id'],
      homeTeam: TeamEntity.fromJson(json['home_team']),
      awayTeam: TeamEntity.fromJson(json['away_team']),
      tour: json['tour'],
      hasStats: json['has_stats'],
      seasonId: json['season_id'],
      seasonName: json['season_name'],
      visitors: json['visitors'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'tournament_id': tournamentId,
      'home_team': homeTeam.toJson(),
      'away_team': awayTeam.toJson(),
      'tour': tour,
      'has_stats': hasStats,
      'season_id': seasonId,
      'season_name': seasonName,
      'visitors': visitors,
    };
  }

  @override
  List<Object?> get props => [
        id,
        date,
        tournamentId,
        homeTeam,
        awayTeam,
        tour,
        hasStats,
        seasonId,
        seasonName,
        visitors,
      ];
}

// Helper class for parsing list of matches
class MatchListEntity {
  static List<MatchEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => MatchEntity.fromJson(json)).toList();
  }
}
