import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/features/game/data/entities/match_lineup_entity.dart';
import 'package:jankuier_mobile/features/game/data/entities/player_stat_entity.dart';
import 'package:jankuier_mobile/features/game/data/entities/team_stat_entity.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/interface/game_interface.dart';
import '../datasources/game_datasource.dart';

class GameRepository implements GameInterface {
  final GameDSInterface gameDSInterface;
  const GameRepository(this.gameDSInterface);

  @override
  ResultFuture<MatchLineupEntity> GetMatchLineUpStatsByGameId(
      String gameId) async {
    try {
      final result =
          await this.gameDSInterface.GetMatchLineUpStatsByGameId(gameId);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<PlayersStatsResponseEntity> GetPlayerStatsByGameId(
      String gameId) async {
    try {
      final result = await this.gameDSInterface.GetPlayerStatsByGameId(gameId);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<TeamsStatsResponseEntity> GetTeamStatsByGameId(
      String gameId) async {
    try {
      final result = await this.gameDSInterface.GetTeamStatsByGameId(gameId);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }
}
