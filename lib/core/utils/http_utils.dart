import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/routes/app_router.dart';
import 'package:jankuier_mobile/core/utils/toasters.dart';
import 'package:talker/talker.dart';
import '../di/injection.dart';
import '../network/dio_client.dart';
import 'hive_utils.dart';

class HttpUtil {
  final Dio dio = getIt<DioClient>().dio;
  final Talker talker = getIt<Talker>();
  final HiveUtils _hiveUtils = getIt<HiveUtils>();

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

  Future<Map<String, String>> _getHeaders(
      Map<String, String>? additionalHeaders) async {
    final headers = <String, String>{
      "Content-Type": "application/json",
    };

    // Add Bearer token if available
    final accessToken = await _hiveUtils.getAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $accessToken';
    }

    // Add any additional headers
    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  Future<void> _handle401Error() async {
    try {
      // Clear user data and token from Hive
      await _hiveUtils.clearAccessToken();
      await _hiveUtils.clearCurrentUser();

      // Navigate to SignIn page using the router
      AppRouter.router.go(AppRouteConstants.SignInPagePath);
    } catch (e) {
      talker.error('Error handling 401 unauthorized', e);
    }
  }

  Future<dynamic> _request({
    required String method,
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final requestHeaders = await _getHeaders(headers);

      final response = await dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(
          method: method,
          headers: requestHeaders,
          responseType: ResponseType.json,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      talker.error('HTTP $method $path', e);

      // Handle 401 Unauthorized error
      if (e.response?.statusCode == 401) {
        await _handle401Error();
        AppToaster.showError("Сессия истекла. Войдите заново");
      } else {
        AppToaster.showError("Ошибка сети: ${e.message}");
      }
      // throw AppException.fromDioError(e);
    } catch (e, st) {
      talker.handle(e, st);
      AppToaster.showError("Неизвестная ошибка");
      // throw AppException(message: 'Unexpected error');
    }
  }
}
