import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/constants/sota_api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/sota_http_utils.dart';
import '../../domain/parameters/match_parameter.dart';
import '../entities/match_entity.dart';
import '../entities/score_table_team_entity.dart';

abstract class StandingDSInterface {
  Future<List<ScoreTableTeamEntity>> getStandingsTableFromSota();
  Future<List<MatchEntity>> getMatchesFromSota(MatchParameter params);
}

class StandingDSImpl implements StandingDSInterface {
  final httpUtils = SotaHttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<List<ScoreTableTeamEntity>> getStandingsTableFromSota() async {
    try {
      final response = await httpUtils
          .get(SotaApiConstant.GetScoreTableUrl(SotaApiConstant.SeasonId));
      final result = ScoreTableTeamListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<MatchEntity>> getMatchesFromSota(MatchParameter params) async {
    try {
      final response = await httpUtils.get(SotaApiConstant.GetGamesURL,
          queryParameters: params.toMap());
      final result = MatchListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
