import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/constants/hive_constants.dart';
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

  // Вспомогательный метод для рекурсивной конвертации Map
  Map<String, dynamic> _convertMap(Map map) {
    return map.map((key, value) {
      if (value is Map) {
        return MapEntry(key.toString(), _convertMap(value));
      } else if (value is List) {
        return MapEntry(key.toString(), _convertList(value));
      }
      return MapEntry(key.toString(), value);
    });
  }

  // Вспомогательный метод для конвертации List
  List<dynamic> _convertList(List list) {
    return list.map((item) {
      if (item is Map) {
        return _convertMap(item);
      } else if (item is List) {
        return _convertList(item);
      }
      return item;
    }).toList();
  }

  @override
  Future<List<ScoreTableTeamEntity>> getStandingsTableFromSota() async {
    try {
      int? activeSeasonId =
          await hiveUtils.get<int>(HiveConstant.activeSeasonIdKey);
      int seasonId = activeSeasonId ?? SotaApiConstant.SeasonId;

      // Создаём уникальный ключ на основе seasonId
      final cacheKey = 'standings_table_sota_season_$seasonId';

      // Пытаемся получить из кэша
      final cachedData = await hiveUtils.get<Map<String, dynamic>>(cacheKey);
      if (cachedData != null) {
        // Данные найдены в кэше и еще актуальны (TTL не истек)
        // Преобразуем dynamic map в Map<String, dynamic> рекурсивно
        final convertedData = _convertMap(cachedData);
        final result_raw = ScoreTableResponseEntity.fromJson(convertedData);
        return result_raw.data.table;
      }

      // Данных нет в кэше или они устарели - делаем запрос к API
      final response =
          await httpUtils.get(SotaApiConstant.GetScoreTableUrl(seasonId));

      // Сохраняем в кэш на 30 минут
      await hiveUtils.put(
        cacheKey,
        response as Map<String, dynamic>,
        ttl: const Duration(minutes: 30),
      );

      final result_raw = ScoreTableResponseEntity.fromJson(response);
      final result = result_raw.data.table;
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
      // Создаём уникальный ключ на основе query параметров
      final queryMap = params.toMap();
      final cacheKey =
          'matches_sota_${queryMap.entries.map((e) => '${e.key}=${e.value}').join('_')}';

      // Пытаемся получить из кэша
      final cachedData = await hiveUtils.get<List>(cacheKey);
      if (cachedData != null) {
        // Данные найдены в кэше и еще актуальны (TTL не истек)
        // Преобразуем dynamic list в правильный формат рекурсивно
        final convertedList = _convertList(cachedData);
        return MatchListEntity.fromJsonList(convertedList);
      }

      // Данных нет в кэше или они устарели - делаем запрос к API
      final response = await httpUtils.get(SotaApiConstant.GetGamesURL,
          queryParameters: queryMap);

      // Сохраняем в кэш на 10 минут
      await hiveUtils.put(
        cacheKey,
        response as List,
        ttl: const Duration(minutes: 30),
      );

      final result = MatchListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
