import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/constants/app_route_constants.dart';
import 'package:jankuier_mobile/core/routes/app_router.dart';
import 'package:talker/talker.dart';
import '../di/injection.dart';
import '../errors/exception.dart';
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

  /// Парсит структурированный ответ об ошибке от API
  /// Ожидаемый формат: { "detail": { "message": "...", "is_custom": true, "details": "..." } }
  ApiException _parseApiError(DioException dioError) {
    final statusCode = dioError.response?.statusCode ?? 500;
    final responseData = dioError.response?.data;

    // Если данные ответа отсутствуют
    if (responseData == null) {
      return ApiException.create(
        statusCode: statusCode,
        message: dioError.message ?? 'Network error',
        isCustom: false,
      );
    }

    // Если это структурированный ответ с полем "detail"
    if (responseData is Map<String, dynamic> &&
        responseData.containsKey('detail')) {
      final detail = responseData['detail'];

      if (detail is Map<String, dynamic>) {
        final message = detail['message']?.toString() ?? 'Unknown error';
        final isCustom = detail['is_custom'] as bool? ?? true;
        final details = detail['details']?.toString();

        // Добавляем дополнительную информацию в extra
        final Map<String, dynamic> extra = {};
        if (details != null && details.isNotEmpty) {
          extra['details'] = details;
        }
        // Добавляем все остальные поля из detail в extra
        detail.forEach((key, value) {
          if (key != 'message' && key != 'is_custom') {
            extra[key] = value;
          }
        });

        return ApiException.create(
          statusCode: statusCode,
          message: message,
          extra: extra.isNotEmpty ? extra : null,
          isCustom: isCustom,
        );
      }
    }

    // Если это простое сообщение об ошибке
    if (responseData is Map<String, dynamic>) {
      final message = responseData['message']?.toString() ??
          responseData['error']?.toString() ??
          'Server error';

      return ApiException.create(
        statusCode: statusCode,
        message: message,
        extra: responseData,
        isCustom: responseData.containsKey('is_custom')
            ? responseData['is_custom'] as bool? ?? true
            : false,
      );
    }

    // Если ответ не в ожидаемом формате
    return ApiException.create(
      statusCode: statusCode,
      message: responseData.toString(),
      isCustom: false,
    );
  }

  /// Получает пользовательское сообщение для отображения
  String _getUserFriendlyMessage(ApiException exception) {
    // Если есть кастомное сообщение от сервера
    if (exception.isCustom && exception.message.isNotEmpty) {
      return exception.message;
    }

    // Стандартные сообщения для разных статус-кодов
    switch (exception.statusCode) {
      case 400:
        return 'Некорректный запрос';
      case 401:
        return 'Необходима авторизация';
      case 403:
        return 'Доступ запрещен';
      case 404:
        return 'Ресурс не найден';
      case 422:
        return 'Ошибка валидации данных';
      case 429:
        return 'Слишком много запросов. Попробуйте позже';
      case 500:
        return 'Внутренняя ошибка сервера';
      case 502:
        return 'Сервер недоступен';
      case 503:
        return 'Сервис временно недоступен';
      default:
        return exception.message.isNotEmpty
            ? exception.message
            : 'Произошла ошибка';
    }
  }

  Future<void> _handle401Error() async {
    try {
      // Clear user data and token from Hive
      await _hiveUtils.clearAccessToken();
      // Navigate to SignIn page using the router
      AppRouter.router.go(AppRouteConstants.RefreshTokenViaLocalAuthPagePath);
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
      // Парсим структурированную ошибку
      final apiException = _parseApiError(e);

      // Логируем детальную информацию об ошибке
      talker.error('HTTP $method $path - ${apiException.statusCode}', {
        'message': apiException.message,
        'isCustom': apiException.isCustom,
        'extra': apiException.extra,
        'originalError': e.toString(),
      });

      // Обрабатываем конкретные статус-коды
      switch (apiException.statusCode) {
        case 401:
          await _handle401Error();
          break;
        default:
          // Для всех остальных ошибок просто логируем и пробрасываем дальше
          break;
      }

      // Выбрасываем исключение для обработки в вызывающем коде (BLoC/UseCase)
      throw apiException;
    } catch (e, st) {
      // Обрабатываем неожиданные ошибки
      talker.handle(e, st);

      if (e is! ApiException) {
        // Создаем ApiException для неожиданных ошибок
        throw ApiException.create(
          statusCode: 0,
          message: e.toString(),
          isCustom: false,
        );
      }

      // Перебрасываем ApiException без изменений
      rethrow;
    }
  }
}
