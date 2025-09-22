import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/network/kff_dio_client.dart';
import 'package:jankuier_mobile/core/utils/toasters.dart';
import 'package:talker/talker.dart';
import '../di/injection.dart';
import '../network/kff_league_dio_client.dart';
import '../network/sota_dio_client.dart';

class KffLeagueHttpUtil {
  final Dio dio = getIt<KffLeagueApiDio>().dio;
  final Talker talker = getIt<Talker>();

  Future<dynamic> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _request(
      method: 'POST',
      path: path,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _request(
      method: 'GET',
      path: path,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<dynamic> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _request(
      method: 'PUT',
      path: path,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<dynamic> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    return _request(
      method: 'DELETE',
      path: path,
      data: data,
      queryParameters: queryParameters,
      headers: headers,
    );
  }

  Future<dynamic> _request({
    required String method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: {
            "Content-Type": "application/json",
            ...?headers,
          },
          responseType: ResponseType.json,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      talker.error('HTTP $method $path', e);
      AppToaster.showError("Ошибка сети: ${e.message}");
      rethrow; // Возвращаем исключение для обработки в вызывающем коде
    } catch (e, st) {
      talker.handle(e, st);
      AppToaster.showError("Неизвестная ошибка");
      rethrow; // Возвращаем исключение для обработки в вызывающем коде
    }
  }
}
