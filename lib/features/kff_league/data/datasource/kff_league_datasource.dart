import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_championship_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_season_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_common_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_match_parameter.dart';
import '../../../../core/constants/kff_league_api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/kff_league_http_utils.dart';
import '../entities/kff_league_match_entity.dart';
import '../entities/kff_league_pagination_response_entity.dart';
import '../entities/kff_league_tournament_entity.dart';

abstract class KffLeagueDSInterface {
  //Get Seasons
  Future<KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity>> getSeasons(
      KffLeagueCommonParameter parameter);
  Future<KffLeagueSingleResponseEntity<KffLeagueSeasonEntity>> getSeasonById(
      int seasonId);
  //Get Championships
  Future<KffLeaguePaginatedResponseEntity<KffLeagueChampionshipEntity>>
      getChampionships(KffLeagueCommonParameter parameter);
  Future<KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity>>
      getChampionshipById(int championshipId);
  //Get Tournaments
  Future<KffLeagueTournamentWithSeasonsResponseEntity> getTournaments();
  Future<KffLeagueTournamentWithSeasonsSingleResponseEntity> getTournamentById(
      int tournamentId);
  //Get Matches
  Future<KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>> getMatches(
      KffLeagueClubMatchParameters parameter);
  Future<KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity>> getMatchById(
      int matchId);
}

@Injectable(as: KffLeagueDSInterface)
class KffLeagueDSImpl implements KffLeagueDSInterface {
  final httpUtils = KffLeagueHttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity>>
      getChampionshipById(int championshipId) async {
    try {
      final response = await httpUtils
          .get(KffLeagueApiConstant.championship(championshipId));
      final result = KffLeagueSingleResponseEntity.fromJson(
          response, KffLeagueChampionshipEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeaguePaginatedResponseEntity<KffLeagueChampionshipEntity>>
      getChampionships(KffLeagueCommonParameter parameter) async {
    try {
      final response = await httpUtils.get(KffLeagueApiConstant.championships(),
          queryParameters: parameter.toQueryParameters());
      final result = KffLeaguePaginatedResponseEntity.fromJson(
          response, KffLeagueChampionshipEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity>> getMatchById(
      int matchId) async {
    try {
      final response = await httpUtils.get(KffLeagueApiConstant.match(matchId));
      final result = KffLeagueSingleResponseEntity.fromJson(
          response, KffLeagueClubMatchEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>> getMatches(
      KffLeagueClubMatchParameters parameter) async {
    try {
      final response = await httpUtils.get(KffLeagueApiConstant.matches(),
          queryParameters: parameter.toQueryParameters());
      final result = KffLeaguePaginatedResponseEntity.fromJson(
          response, KffLeagueClubMatchEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeagueSingleResponseEntity<KffLeagueSeasonEntity>> getSeasonById(
      int seasonId) async {
    try {
      final response =
          await httpUtils.get(KffLeagueApiConstant.season(seasonId));
      final result = KffLeagueSingleResponseEntity.fromJson(
          response, KffLeagueSeasonEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity>> getSeasons(
      KffLeagueCommonParameter parameter) async {
    try {
      final response = await httpUtils.get(KffLeagueApiConstant.seasons(),
          queryParameters: parameter.toQueryParameters());
      final result = KffLeaguePaginatedResponseEntity.fromJson(
          response, KffLeagueSeasonEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeagueTournamentWithSeasonsSingleResponseEntity> getTournamentById(
      int tournamentId) async {
    try {
      final response =
          await httpUtils.get(KffLeagueApiConstant.tournament(tournamentId));
      final result =
          KffLeagueTournamentWithSeasonsSingleResponseEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<KffLeagueTournamentWithSeasonsResponseEntity> getTournaments() async {
    try {
      final response = await httpUtils.get(KffLeagueApiConstant.tournaments());
      final result =
          KffLeagueTournamentWithSeasonsResponseEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
