import 'package:equatable/equatable.dart';

class KffTeamImageEntity extends Equatable {
  final String? original;
  final String? square;
  final String? thumb;
  final String? avatar;
  final String? content;

  const KffTeamImageEntity({
    this.original,
    this.square,
    this.thumb,
    this.avatar,
    this.content,
  });

  factory KffTeamImageEntity.fromJson(Map<String, dynamic> json) {
    return KffTeamImageEntity(
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

class KffTeamEntity extends Equatable {
  final int id;
  final String? title;
  final KffTeamImageEntity? image;

  const KffTeamEntity({
    required this.id,
    this.title,
    this.image,
  });

  factory KffTeamEntity.fromJson(Map<String, dynamic> json) {
    return KffTeamEntity(
      id: json['id'],
      title: json['title'],
      image: json['image'] != null
          ? KffTeamImageEntity.fromJson(json['image'])
          : null,
    );
  }

  @override
  List<Object?> get props => [id, title, image];
}

class KffChampionshipEntity extends Equatable {
  final int id;
  final String? title;

  const KffChampionshipEntity({
    required this.id,
    this.title,
  });

  factory KffChampionshipEntity.fromJson(Map<String, dynamic> json) {
    return KffChampionshipEntity(
      id: json['id'],
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, title];
}

class KffLeagueMatchEntity extends Equatable {
  final int id;
  final String? startedAt;
  final int? team1Score;
  final int? team2Score;
  final int? tour;
  final String? protocol;
  final int? startedAtTs;
  final KffTeamEntity? team1;
  final KffTeamEntity? team2;
  final KffChampionshipEntity? championship;

  const KffLeagueMatchEntity({
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

  factory KffLeagueMatchEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueMatchEntity(
      id: json['id'],
      startedAt: json['started_at'],
      team1Score: json['team1_score'],
      team2Score: json['team2_score'],
      tour: json['tour'],
      protocol: json['protocol'],
      startedAtTs: json['started_at_ts'],
      team1:
          json['team1'] != null ? KffTeamEntity.fromJson(json['team1']) : null,
      team2:
          json['team2'] != null ? KffTeamEntity.fromJson(json['team2']) : null,
      championship: json['championship'] != null
          ? KffChampionshipEntity.fromJson(json['championship'])
          : null,
    );
  }

  /// Парсинг даты начала матча
  DateTime? get startedAtDateTime {
    if (startedAt == null) return null;
    try {
      return DateTime.parse(startedAt!.replaceAll(' ', 'T'));
    } catch (e) {
      return null;
    }
  }

  /// Парсинг даты из timestamp
  DateTime? get startedAtFromTimestamp {
    if (startedAtTs == null) return null;
    return DateTime.fromMillisecondsSinceEpoch(startedAtTs! * 1000);
  }

  /// Проверка завершенности матча
  bool get isFinished => team1Score != null && team2Score != null;

  /// Результат матча в формате "2:1"
  String get scoreDisplay {
    if (!isFinished) return "-:-";
    return "${team1Score ?? 0}:${team2Score ?? 0}";
  }

  /// Краткое описание матча
  String get matchDescription {
    final team1Name = team1?.title ?? "Команда 1";
    final team2Name = team2?.title ?? "Команда 2";
    return "$team1Name vs $team2Name";
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

class KffLeagueMatchListEntity {
  static List<KffLeagueMatchEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => KffLeagueMatchEntity.fromJson(json)).toList();
  }
}
