import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/team_stat_entity.dart';
import '../interface/game_interface.dart';

class GetTeamStatsByGameIdCase
    extends UseCaseWithParams<TeamsStatsResponseEntity, String> {
  final GameInterface _gameInterface;
  const GetTeamStatsByGameIdCase(this._gameInterface);

  @override
  ResultFuture<TeamsStatsResponseEntity> call(String gameId) {
    return _gameInterface.GetTeamStatsByGameId(gameId);
  }
}
