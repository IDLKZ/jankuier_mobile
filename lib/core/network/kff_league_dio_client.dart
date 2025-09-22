import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../constants/hive_constants.dart';
import '../constants/kff_api_constants.dart';
import '../constants/kff_league_api_constants.dart';
import '../utils/hive_utils.dart';

@injectable
class KffLeagueApiDio {
  late final Dio _dio;

  KffLeagueApiDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: KffLeagueApiConstant.BaseURL,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Добавляем язык
          try {
            const language = "ru";
            options.headers['Accept-Language'] = language;
            options.headers['Authorization'] =
                'Bearer ${KffLeagueApiConstant.Token}';
          } catch (e) {
            // Ignore
          }
          handler.next(options);
        },
        onError: (error, handler) async {
          // Если получили 401 ошибку, пробуем обновить токен
          if (error.response?.statusCode == 401) {
            try {
              // Удаляем старый токен из кеша
              final hiveUtils = HiveUtils();
              await hiveUtils.delete(HiveConstant.SotaTokenKey);
              print('Token expired, need to refresh');
            } catch (e) {
              print('Failed to handle token refresh: $e');
            }
          }
          handler.next(error);
        },
      ),
    );
  }

  Dio get dio => _dio;
}
