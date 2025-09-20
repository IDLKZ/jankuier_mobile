import 'package:equatable/equatable.dart';

// Основная Entity для матча
class KffLeaguePostMatchEntity extends Equatable {
  final int id;
  final String? startedAt;
  final int? team1Score;
  final int? team2Score;
  final int? tour;
  final String? protocol;
  final int? startedAtTs;
  final KffLeaguePostMatchTeamEntity? team1;
  final KffLeaguePostMatchTeamEntity? team2;
  final KffLeaguePostMatchChampionshipEntity? championship;

  const KffLeaguePostMatchEntity({
    required this.id,
    this.startedAt,
    this.team1Score,
    this.team2Score,
    this.tour,
    this.protocol,
    this.startedAtTs,
    this.team1,
    this.team2,
    this.championship,
  });

  factory KffLeaguePostMatchEntity.fromJson(Map<String, dynamic> json) {
    return KffLeaguePostMatchEntity(
      id: json['id'] ?? 0,
      startedAt: json['started_at'],
      team1Score: json['team1_score'],
      team2Score: json['team2_score'],
      tour: json['tour'],
      protocol: json['protocol'],
      startedAtTs: json['started_at_ts'],
      team1: json['team1'] != null
          ? KffLeaguePostMatchTeamEntity.fromJson(json['team1'])
          : null,
      team2: json['team2'] != null
          ? KffLeaguePostMatchTeamEntity.fromJson(json['team2'])
          : null,
      championship: json['championship'] != null
          ? KffLeaguePostMatchChampionshipEntity.fromJson(json['championship'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        startedAt,
        team1Score,
        team2Score,
        tour,
        protocol,
        startedAtTs,
        team1,
        team2,
        championship,
      ];
}

// Entity для команды
class KffLeaguePostMatchTeamEntity extends Equatable {
  final int id;
  final String? title;
  final KffLeaguePostMatchImageEntity? image;

  const KffLeaguePostMatchTeamEntity({
    required this.id,
    this.title,
    this.image,
  });

  factory KffLeaguePostMatchTeamEntity.fromJson(Map<String, dynamic> json) {
    return KffLeaguePostMatchTeamEntity(
      id: json['id'] ?? 0,
      title: json['title'],
      image: json['image'] != null
          ? KffLeaguePostMatchImageEntity.fromJson(json['image'])
          : null,
    );
  }

  @override
  List<Object?> get props => [id, title, image];
}

// Entity для изображений
class KffLeaguePostMatchImageEntity extends Equatable {
  final String? original;
  final String? square;
  final String? thumb;
  final String? avatar;
  final String? content;

  const KffLeaguePostMatchImageEntity({
    this.original,
    this.square,
    this.thumb,
    this.avatar,
    this.content,
  });

  factory KffLeaguePostMatchImageEntity.fromJson(Map<String, dynamic> json) {
    return KffLeaguePostMatchImageEntity(
      original: json['original'],
      square: json['square'],
      thumb: json['thumb'],
      avatar: json['avatar'],
      content: json['content'],
    );
  }

  @override
  List<Object?> get props => [original, square, thumb, avatar, content];
}

// Entity для чемпионата
class KffLeaguePostMatchChampionshipEntity extends Equatable {
  final int id;
  final String? title;

  const KffLeaguePostMatchChampionshipEntity({
    required this.id,
    this.title,
  });

  factory KffLeaguePostMatchChampionshipEntity.fromJson(
      Map<String, dynamic> json) {
    return KffLeaguePostMatchChampionshipEntity(
      id: json['id'] ?? 0,
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, title];
}

// Список Entity
class KffLeaguePostMatchListEntity {
  static List<KffLeaguePostMatchEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => KffLeaguePostMatchEntity.fromJson(json))
        .toList();
  }
}

// Response wrapper
class KffLeaguePostMatchResponseEntity extends Equatable {
  final bool success;
  final int code;
  final List<KffLeaguePostMatchEntity> data;

  const KffLeaguePostMatchResponseEntity({
    required this.success,
    required this.code,
    required this.data,
  });

  factory KffLeaguePostMatchResponseEntity.fromJson(Map<String, dynamic> json) {
    return KffLeaguePostMatchResponseEntity(
      success: json['success'] ?? false,
      code: json['code'] ?? 0,
      data: json['data'] != null
          ? KffLeaguePostMatchListEntity.fromJsonList(json['data'])
          : <KffLeaguePostMatchEntity>[],
    );
  }

  @override
  List<Object?> get props => [success, code, data];
}
