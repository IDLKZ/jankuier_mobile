// Обновленный SotaApiDio
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../constants/hive_constants.dart';
import '../constants/sota_api_constants.dart';
import '../utils/hive_utils.dart';

@injectable
class SotaApiDio {
  late final Dio _dio;

  SotaApiDio() {
    _dio = Dio(
      BaseOptions(
        baseUrl: SotaApiConstant.BaseURL,
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
          // Пропускаем добавление токена для URL получения токена
          if (!options.path.contains('auth/token/')) {
            try {
              final hiveUtils = HiveUtils();
              final cached = await hiveUtils
                  .get<Map<String, dynamic>>(HiveConstant.SotaTokenKey);
              if (cached != null && cached['access'] != null) {
                options.headers['Authorization'] = 'Bearer ${cached['access']}';
              }
            } catch (e) {
              // Если не удалось получить токен, продолжаем без него
              print('Failed to get SOTA token: $e');
            }
          }

          // Добавляем язык
          try {
            const language = "ru";
            options.headers['Accept-Language'] = language;
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
