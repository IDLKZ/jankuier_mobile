import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/player_stat_entity.dart';
import '../interface/game_interface.dart';

class GetPlayerStatsByGameIdCase
    extends UseCaseWithParams<PlayersStatsResponseEntity, String> {
  final GameInterface _gameInterface;
  const GetPlayerStatsByGameIdCase(this._gameInterface);

  @override
  ResultFuture<PlayersStatsResponseEntity> call(String gameId) {
    return _gameInterface.GetPlayerStatsByGameId(gameId);
  }
}
