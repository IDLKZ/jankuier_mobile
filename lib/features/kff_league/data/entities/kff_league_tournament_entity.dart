import 'package:equatable/equatable.dart';

// Entity для мультиязычных заголовков (остается той же)
class KffLeagueTitleEntity extends Equatable {
  final String? ru;
  final String? kz;
  final String? en;

  const KffLeagueTitleEntity({
    this.ru,
    this.kz,
    this.en,
  });

  factory KffLeagueTitleEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueTitleEntity(
      ru: json['ru'],
      kz: json['kz'],
      en: json['en'],
    );
  }

  @override
  List<Object?> get props => [ru, kz, en];
}

// Entity для сезона (упрощенная версия)
class KffLeagueSeasonInfoEntity extends Equatable {
  final int id;
  final String? title;

  const KffLeagueSeasonInfoEntity({
    required this.id,
    this.title,
  });

  factory KffLeagueSeasonInfoEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueSeasonInfoEntity(
      id: json['id'] ?? 0,
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, title];
}

// Entity для детального сезона/турнира
class KffLeagueTournamentSeasonEntity extends Equatable {
  final int? tournamentId;
  final KffLeagueTitleEntity? title;
  final String? logo;
  final String? statisticsType;
  final int? status;
  final int? position;
  final String? vsporteId;
  final String? geniusId;
  final String? sotaId;
  final int? gamesTotal;
  final KffLeagueSeasonInfoEntity? season;

  const KffLeagueTournamentSeasonEntity({
    this.tournamentId,
    this.title,
    this.logo,
    this.statisticsType,
    this.status,
    this.position,
    this.vsporteId,
    this.geniusId,
    this.sotaId,
    this.gamesTotal,
    this.season,
  });

  factory KffLeagueTournamentSeasonEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueTournamentSeasonEntity(
      tournamentId: json['tournament_id'],
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
      logo: json['logo'],
      statisticsType: json['statistics_type'],
      status: json['status'],
      position: json['position'],
      vsporteId: json['vsporte_id'],
      geniusId: json['genius_id'],
      sotaId: json['sota_id'],
      gamesTotal: json['games_total'],
      season: json['season'] != null
          ? KffLeagueSeasonInfoEntity.fromJson(json['season'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        tournamentId,
        title,
        logo,
        statisticsType,
        status,
        position,
        vsporteId,
        geniusId,
        sotaId,
        gamesTotal,
        season,
      ];
}

// Entity для турнира с сезонами
class KffLeagueTournamentWithSeasonsEntity extends Equatable {
  final int id;
  final String? slug;
  final KffLeagueTitleEntity? title;
  final String? logo;
  final String? tournamentClass;
  final int? status;
  final int? withLink;
  final String? sotaId;
  final List<KffLeagueTournamentSeasonEntity>? seasons;

  const KffLeagueTournamentWithSeasonsEntity({
    required this.id,
    this.slug,
    this.title,
    this.logo,
    this.tournamentClass,
    this.status,
    this.withLink,
    this.sotaId,
    this.seasons,
  });

  factory KffLeagueTournamentWithSeasonsEntity.fromJson(
      Map<String, dynamic> json) {
    return KffLeagueTournamentWithSeasonsEntity(
      id: json['id'] ?? 0,
      slug: json['slug'],
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
      logo: json['logo'],
      tournamentClass: json['class'],
      status: json['status'],
      withLink: json['with_link'],
      sotaId: json['sota_id'],
      seasons: json['seasons'] != null
          ? (json['seasons'] as List<dynamic>)
              .map((season) => KffLeagueTournamentSeasonEntity.fromJson(season))
              .toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        slug,
        title,
        logo,
        tournamentClass,
        status,
        withLink,
        sotaId,
        seasons,
      ];
}

// Response Entity для турниров с сезонами
class KffLeagueTournamentWithSeasonsResponseEntity extends Equatable {
  final List<KffLeagueTournamentWithSeasonsEntity> data;

  const KffLeagueTournamentWithSeasonsResponseEntity({
    required this.data,
  });

  factory KffLeagueTournamentWithSeasonsResponseEntity.fromJson(
      Map<String, dynamic> json) {
    return KffLeagueTournamentWithSeasonsResponseEntity(
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map(
                  (item) => KffLeagueTournamentWithSeasonsEntity.fromJson(item))
              .toList()
          : <KffLeagueTournamentWithSeasonsEntity>[],
    );
  }

  @override
  List<Object?> get props => [data];
}

// Response Entity для одного турнира с сезонами
class KffLeagueTournamentWithSeasonsSingleResponseEntity extends Equatable {
  final KffLeagueTournamentWithSeasonsEntity? data;

  const KffLeagueTournamentWithSeasonsSingleResponseEntity({
    this.data,
  });

  factory KffLeagueTournamentWithSeasonsSingleResponseEntity.fromJson(
      Map<String, dynamic> json) {
    return KffLeagueTournamentWithSeasonsSingleResponseEntity(
      data: json['data'] != null
          ? KffLeagueTournamentWithSeasonsEntity.fromJson(json['data'])
          : null,
    );
  }

  @override
  List<Object?> get props => [data];
}
