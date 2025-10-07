import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';
import '../../../../core/common/entities/city_entity.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../domain/parameters/get_city_parameter.dart';
import '../../domain/parameters/get_country_parameter.dart';

abstract class CountryDSInterface {
  Future<SotaPaginationResponse<CountryEntity>> getCountriesFromSota(
      GetCountryParameter parameter);
  Future<List<CityEntity>> getCities(CityFilterParameter parameter);
}

class CountryDSImpl implements CountryDSInterface {
  final httpUtils = HttpUtil();
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
  Future<SotaPaginationResponse<CountryEntity>> getCountriesFromSota(
      GetCountryParameter parameter) async {
    try {
      // Создаём уникальный ключ на основе query параметров
      final queryMap = parameter.toMap();
      final cacheKey =
          'countries_sota_${queryMap.entries.map((e) => '${e.key}=${e.value}').join('_')}';

      // Пытаемся получить из кэша
      final cachedData = await hiveUtils.get<Map<String, dynamic>>(cacheKey);
      if (cachedData != null) {
        // Данные найдены в кэше и еще актуальны (TTL не истек)
        // Преобразуем dynamic map в Map<String, dynamic> рекурсивно
        final convertedData = _convertMap(cachedData);
        return SotaPaginationResponse<CountryEntity>.fromJson(
            convertedData, CountryEntity.fromJson);
      }

      // Данных нет в кэше или они устарели - делаем запрос к API
      final response = await httpUtils.get(ApiConstant.GetCountryURL,
          queryParameters: queryMap);

      // Сохраняем в кэш на 10 минут
      await hiveUtils.put(
        cacheKey,
        response as Map<String, dynamic>,
        ttl: const Duration(minutes: 30),
      );

      final result = SotaPaginationResponse<CountryEntity>.fromJson(
          response, CountryEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<CityEntity>> getCities(CityFilterParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.GetAllCitiesUrl,
          queryParameters: parameter.toQueryParameters());
      final result = CityListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
