import 'package:equatable/equatable.dart';

import 'kff_league_championship_entity.dart';

// Entity для стадии/тура
class KffLeagueClubMatchStageEntity extends Equatable {
  final int id;
  final KffLeagueTitleEntity? title;

  const KffLeagueClubMatchStageEntity({
    required this.id,
    this.title,
  });

  factory KffLeagueClubMatchStageEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueClubMatchStageEntity(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
    );
  }

  @override
  List<Object?> get props => [id, title];
}

// Entity для команды в матче
class KffLeagueClubMatchTeamEntity extends Equatable {
  final int id;
  final KffLeagueTitleEntity? title;
  final String? shortTitle;
  final String? logo;

  const KffLeagueClubMatchTeamEntity({
    required this.id,
    this.title,
    this.shortTitle,
    this.logo,
  });

  factory KffLeagueClubMatchTeamEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueClubMatchTeamEntity(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
      shortTitle: json['short_title'],
      logo: json['logo'],
    );
  }

  @override
  List<Object?> get props => [id, title, shortTitle, logo];
}

// Entity для стадиона
class KffLeagueClubMatchStadiumEntity extends Equatable {
  final int id;
  final KffLeagueTitleEntity? title;
  final String? photo;

  const KffLeagueClubMatchStadiumEntity({
    required this.id,
    this.title,
    this.photo,
  });

  factory KffLeagueClubMatchStadiumEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueClubMatchStadiumEntity(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
      photo: json['photo'],
    );
  }

  @override
  List<Object?> get props => [id, title, photo];
}

// Entity для сезона в матче
class KffLeagueClubMatchSeasonEntity extends Equatable {
  final int id;
  final String? title;

  const KffLeagueClubMatchSeasonEntity({
    required this.id,
    this.title,
  });

  factory KffLeagueClubMatchSeasonEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueClubMatchSeasonEntity(
      id: json['id'] ?? 0,
      title: json['title'],
    );
  }

  @override
  List<Object?> get props => [id, title];
}

// Entity для турнира в матче
class KffLeagueClubMatchTournamentEntity extends Equatable {
  final int id;
  final KffLeagueTitleEntity? title;
  final String? logo;
  final KffLeagueClubMatchSeasonEntity? season;

  const KffLeagueClubMatchTournamentEntity({
    required this.id,
    this.title,
    this.logo,
    this.season,
  });

  factory KffLeagueClubMatchTournamentEntity.fromJson(
      Map<String, dynamic> json) {
    return KffLeagueClubMatchTournamentEntity(
      id: json['id'] ?? 0,
      title: json['title'] != null
          ? KffLeagueTitleEntity.fromJson(json['title'])
          : null,
      logo: json['logo'],
      season: json['season'] != null
          ? KffLeagueClubMatchSeasonEntity.fromJson(json['season'])
          : null,
    );
  }

  @override
  List<Object?> get props => [id, title, logo, season];
}

// Основная Entity для матча
class KffLeagueClubMatchEntity extends Equatable {
  final int id;
  final int? active;
  final int? datetime;
  final String? datetimeIso;
  final int? seasonId;
  final int? tournamentId;
  final int? stageId;
  final int? team1Id;
  final int? team2Id;
  final int? stadiumId;
  final String? stadium;
  final int? attendance;
  final int? status;
  final int? result1;
  final int? result2;
  final int? resultpp1;
  final int? resultpp2;
  final String? place;
  final String? protocol;
  final String? liveCode;
  final String? reviewCode;
  final String? sotaCode;
  final String? sotaTeam1;
  final String? sotaTeam2;
  final int? isTourMatch;
  final KffLeagueClubMatchSeasonEntity? season;
  final KffLeagueClubMatchTournamentEntity? tournament;
  final KffLeagueClubMatchStageEntity? stage;
  final KffLeagueClubMatchTeamEntity? team1;
  final KffLeagueClubMatchTeamEntity? team2;
  final KffLeagueClubMatchStadiumEntity? stadiumObj;
  final String? link;

  const KffLeagueClubMatchEntity({
    required this.id,
    this.active,
    this.datetime,
    this.datetimeIso,
    this.seasonId,
    this.tournamentId,
    this.stageId,
    this.team1Id,
    this.team2Id,
    this.stadiumId,
    this.stadium,
    this.attendance,
    this.status,
    this.result1,
    this.result2,
    this.resultpp1,
    this.resultpp2,
    this.place,
    this.protocol,
    this.liveCode,
    this.reviewCode,
    this.sotaCode,
    this.sotaTeam1,
    this.sotaTeam2,
    this.isTourMatch,
    this.season,
    this.tournament,
    this.stage,
    this.team1,
    this.team2,
    this.stadiumObj,
    this.link,
  });

  factory KffLeagueClubMatchEntity.fromJson(Map<String, dynamic> json) {
    return KffLeagueClubMatchEntity(
      id: json['id'] ?? 0,
      active: json['active'],
      datetime: json['datetime'],
      datetimeIso: json['datetime_iso'],
      seasonId: json['season_id'],
      tournamentId: json['tournament_id'],
      stageId: json['stage_id'],
      team1Id: json['team1_id'],
      team2Id: json['team2_id'],
      stadiumId: json['stadium_id'],
      stadium: json['stadium'],
      attendance: json['attendance'],
      status: json['status'],
      result1: json['result1'],
      result2: json['result2'],
      resultpp1: json['resultpp1'],
      resultpp2: json['resultpp2'],
      place: json['place'],
      protocol: json['protocol'],
      liveCode: json['live_code'],
      reviewCode: json['review_code'],
      sotaCode: json['sota_code'],
      sotaTeam1: json['sota_team1'],
      sotaTeam2: json['sota_team2'],
      isTourMatch: json['is_tour_match'],
      season: json['season'] != null
          ? KffLeagueClubMatchSeasonEntity.fromJson(json['season'])
          : null,
      tournament: json['tournament'] != null
          ? KffLeagueClubMatchTournamentEntity.fromJson(json['tournament'])
          : null,
      stage: json['stage'] != null
          ? KffLeagueClubMatchStageEntity.fromJson(json['stage'])
          : null,
      team1: json['team1'] != null
          ? KffLeagueClubMatchTeamEntity.fromJson(json['team1'])
          : null,
      team2: json['team2'] != null
          ? KffLeagueClubMatchTeamEntity.fromJson(json['team2'])
          : null,
      stadiumObj: json['stadium_obj'] != null
          ? KffLeagueClubMatchStadiumEntity.fromJson(json['stadium_obj'])
          : null,
      link: json['link'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        active,
        datetime,
        datetimeIso,
        seasonId,
        tournamentId,
        stageId,
        team1Id,
        team2Id,
        stadiumId,
        stadium,
        attendance,
        status,
        result1,
        result2,
        resultpp1,
        resultpp2,
        place,
        protocol,
        liveCode,
        reviewCode,
        sotaCode,
        sotaTeam1,
        sotaTeam2,
        isTourMatch,
        season,
        tournament,
        stage,
        team1,
        team2,
        stadiumObj,
        link,
      ];
}
