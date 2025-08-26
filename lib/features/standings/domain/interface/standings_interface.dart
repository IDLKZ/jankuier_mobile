import '../../../../core/utils/typedef.dart';
import '../../data/entities/match_entity.dart';
import '../../data/entities/score_table_team_entity.dart';
import '../parameters/match_parameter.dart';

abstract class StandingInterface {
  ResultFuture<List<ScoreTableTeamEntity>> getStandingsTableFromSota();
  ResultFuture<List<MatchEntity>> getMatchesFromSota(MatchParameter params);
}
