import '../../../../core/constants/sota_api_constants.dart';

typedef DataMap = Map<String, String>;

class MatchParameter {
  final int? awayTeamId;
  final int? homeTeamId;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final int? playerId;
  final int? team;
  final int seasonId;
  final int tournamentId;

  const MatchParameter({
    this.awayTeamId,
    this.homeTeamId,
    this.dateFrom,
    this.dateTo,
    this.playerId,
    this.team,
    this.seasonId = SotaApiConstant.SeasonId,
    this.tournamentId = SotaApiConstant.TournamentId,
  });

  DataMap toMap() {
    final map = <String, String>{
      "season_id": seasonId.toString(),
      "tournament_id": tournamentId.toString(),
    };

    if (awayTeamId != null) map["away_team_id"] = awayTeamId.toString();
    if (homeTeamId != null) map["home_team_id"] = homeTeamId.toString();
    if (dateFrom != null) map["date_from"] = _formatDate(dateFrom!);
    if (dateTo != null) map["date_to"] = _formatDate(dateTo!);
    if (playerId != null) map["player_id"] = playerId.toString();
    if (team != null) map["team"] = team.toString();

    return map;
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }
}
