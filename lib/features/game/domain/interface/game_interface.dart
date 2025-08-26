import '../../../../core/utils/typedef.dart';
import '../../data/entities/match_lineup_entity.dart';
import '../../data/entities/player_stat_entity.dart';
import '../../data/entities/team_stat_entity.dart';

abstract class GameInterface {
  ResultFuture<TeamsStatsResponseEntity> GetTeamStatsByGameId(String gameId);
  ResultFuture<PlayersStatsResponseEntity> GetPlayerStatsByGameId(
      String gameId);
  ResultFuture<MatchLineupEntity> GetMatchLineUpStatsByGameId(String gameId);
}
