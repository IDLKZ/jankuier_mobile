import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/match_lineup_entity.dart';
import '../interface/game_interface.dart';

class GetMatchLineUpStatsByGameIdCase
    extends UseCaseWithParams<MatchLineupEntity, String> {
  final GameInterface _gameInterface;
  const GetMatchLineUpStatsByGameIdCase(this._gameInterface);

  @override
  ResultFuture<MatchLineupEntity> call(String gameId) {
    return _gameInterface.GetMatchLineUpStatsByGameId(gameId);
  }
}
