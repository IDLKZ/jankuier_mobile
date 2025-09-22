import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/constants/kff_api_constants.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_common_response.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_coach_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_player_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_post_match_entity.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/kff_http_utils.dart';

abstract class KffDSInterface {
  Future<KffCommonResponseFromList<KffLeagueEntity>> getAllLeague();
  Future<KffCommonResponseFromEntity<KffLeagueEntity>> getOneLeague(
      int leagueId);
  Future<KffCommonResponseFromList<KffLeagueMatchEntity>> getFutureMatches(
      int leagueId);
  Future<KffCommonResponseFromList<KffLeaguePostMatchEntity>> getPastMatches(
      int leagueId);
  Future<KffCommonResponseFromList<KffLeagueCoachEntity>> getCoaches(
      int leagueId);
  Future<KffCommonResponseFromList<KffLeaguePlayerEntity>> getPlayers(
      int leagueId);
}

@Injectable(as: KffDSInterface)
class KffDSImpl implements KffDSInterface {
  final httpUtils = KffHttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<KffCommonResponseFromList<KffLeagueEntity>> getAllLeague() async {
    try {
      final response = await httpUtils.get(KffApiConstant.leagues());
      final result = KffCommonResponseFromList.fromJson(
          response, KffLeagueEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffCommonResponseFromList<KffLeagueCoachEntity>> getCoaches(
      int leagueId) async {
    try {
      final response =
          await httpUtils.get(KffApiConstant.leagueCoaches(leagueId));
      final result = KffCommonResponseFromList.fromJson(
          response, KffLeagueCoachEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffCommonResponseFromList<KffLeagueMatchEntity>> getFutureMatches(
      int leagueId) async {
    try {
      final response =
          await httpUtils.get(KffApiConstant.leagueMatches(leagueId));
      final result = KffCommonResponseFromList.fromJson(
          response, KffLeagueMatchEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffCommonResponseFromEntity<KffLeagueEntity>> getOneLeague(
      int leagueId) async {
    try {
      final response = await httpUtils.get(KffApiConstant.league(leagueId));
      final result = KffCommonResponseFromEntity.fromJson(
          response, KffLeagueEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffCommonResponseFromList<KffLeaguePostMatchEntity>> getPastMatches(
      int leagueId) async {
    try {
      final response =
          await httpUtils.get(KffApiConstant.leaguePastMatches(leagueId));
      final result = KffCommonResponseFromList.fromJson(
          response, KffLeaguePostMatchEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffCommonResponseFromList<KffLeaguePlayerEntity>> getPlayers(
      int leagueId) async {
    try {
      final response =
          await httpUtils.get(KffApiConstant.leaguePlayers(leagueId));
      final result = KffCommonResponseFromList.fromJson(
          response, KffLeaguePlayerEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
