import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/http_utils.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/parameters/get_new_one_parameter.dart';
import '../../domain/parameters/get_news_parameter.dart';
import '../entities/news_response.dart';

abstract class NewsDSInterface {
  /// Yii: https://kff.kz/api/news
  Future<NewsListResponse> getNewsFromKff(GetNewsParameter parameter);
  Future<NewsOneResponse> getNewOneFromKff(GetNewOneParameter parameter);

  /// Laravel: https://kffleague.kz/api/v1/news
  Future<NewsListResponse> getNewsFromKffLeague(GetNewsParameter parameter);
  Future<NewsOneResponse> getNewOneFromKffLeague(GetNewOneParameter parameter);
}

@Injectable(as: NewsDSInterface)
class NewsDSImpl implements NewsDSInterface {
  final httpUtils = HttpUtil();

  // API Token for authentication
  static const String _apiToken = 'cb776410401f84b59ecafc838613cb5bc1c8e8e3ba60d946dbdcb271a1f4bc92';

  // Рекомендуется вынести в константы твоего проекта
  // ignore: constant_identifier_names
  static const String GetKffNewsURL = 'https://kff.kz/api/news';
  // ignore: constant_identifier_names
  static const String GetKffLeagueNewsURL = 'https://kffleague.kz/api/v1/news';

  @override
  Future<NewsListResponse> getNewsFromKff(
      GetNewsParameter parameter,
      ) async {
    try {
      final DataMap query = parameter.toQuery();

      final response = await httpUtils.get(
        GetKffNewsURL,
        headers: {
          'Authorization': 'Bearer $_apiToken',
          'Content-Type': 'application/json',
          if (parameter.acceptLanguage != null)
            'Accept-Language': parameter.acceptLanguage!,
        },
      );

      final result = NewsListResponse.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<NewsListResponse> getNewsFromKffLeague(
      GetNewsParameter parameter,
      ) async {
    try {
      final DataMap query = parameter.toQuery();

      final response = await httpUtils.get(
        GetKffLeagueNewsURL,
        queryParameters: query,
        headers: {
          'Authorization': 'Bearer $_apiToken',
          'Content-Type': 'application/json',
          if (parameter.acceptLanguage != null)
            'Accept-Language': parameter.acceptLanguage!,
        },
      );

      final result = NewsListResponse.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<NewsOneResponse> getNewOneFromKff(GetNewOneParameter parameter) async {
    try {
      final response = await httpUtils.get(
        '$GetKffNewsURL/${parameter.id}',
        headers: {
          'Authorization': 'Bearer $_apiToken',
          'Content-Type': 'application/json',
          if (parameter.acceptLanguage != null)
            'Accept-Language': parameter.acceptLanguage!,
        },
      );

      final result = NewsOneResponse.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<NewsOneResponse> getNewOneFromKffLeague(GetNewOneParameter parameter) async {
    try {
      final response = await httpUtils.get(
        '$GetKffLeagueNewsURL/${parameter.id}',
        headers: {
          'Authorization': 'Bearer $_apiToken',
          'Content-Type': 'application/json',
          if (parameter.acceptLanguage != null)
            'Accept-Language': parameter.acceptLanguage!,
        },
      );

      final result = NewsOneResponse.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
