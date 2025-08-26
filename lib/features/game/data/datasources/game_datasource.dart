import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/constants/hive_constants.dart';
import 'package:jankuier_mobile/core/constants/sota_api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/sota_http_utils.dart';
import '../entities/match_lineup_entity.dart';
import '../entities/player_stat_entity.dart';
import '../entities/team_stat_entity.dart';

abstract class GameDSInterface {
  Future<TeamsStatsResponseEntity> GetTeamStatsByGameId(String gameId);
  Future<PlayersStatsResponseEntity> GetPlayerStatsByGameId(String gameId);
  Future<MatchLineupEntity> GetMatchLineUpStatsByGameId(String gameId);
}

class GameDSImpl implements GameDSInterface {
  final httpUtils = SotaHttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<MatchLineupEntity> GetMatchLineUpStatsByGameId(String gameId) async {
    try {
      final response = await httpUtils
          .get(SotaApiConstant.GetMatchLineUpStatsByGameIdUrl(gameId));
      final result = MatchLineupEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<PlayersStatsResponseEntity> GetPlayerStatsByGameId(
      String gameId) async {
    try {
      final response = await httpUtils
          .get(SotaApiConstant.GetPlayerStatsByGameIdUrl(gameId));
      final result = PlayersStatsResponseEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<TeamsStatsResponseEntity> GetTeamStatsByGameId(String gameId) async {
    try {
      final response =
          await httpUtils.get(SotaApiConstant.GetTeamStatsByGameIdUrl(gameId));
      final result = TeamsStatsResponseEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
