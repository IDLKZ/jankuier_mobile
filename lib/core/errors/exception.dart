import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import '../di/injection.dart';

class ApiException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic>? extra;
  final bool isCustom;

  const ApiException({
    required this.message,
    required this.statusCode,
    this.extra,
    this.isCustom = true,
  });

  static ApiException create({
    required int statusCode,
    required String message,
    Map<String, dynamic>? extra,
    bool isCustom = true,
  }) {
    final detail = {
      'message': message,
      'is_custom': isCustom,
      if (extra != null) ...extra,
    };

    final talker = getIt<Talker>();
    talker.error('Error $statusCode: $detail');

    return ApiException(
      statusCode: statusCode,
      message: message,
      extra: extra,
      isCustom: isCustom,
    );
  }

  factory ApiException.fromDioError(DioException dioError) {
    final statusCode = dioError.response?.statusCode ?? 500;
    final data = dioError.response?.data;
    // Проверяем структурированный ответ с полем "detail"
    if (data is Map<String, dynamic> && data.containsKey('detail')) {
      final detail = data['detail'];

      if (detail is Map<String, dynamic>) {
        final message = detail['message']?.toString() ?? 'Unknown error';
        final isCustom = detail['is_custom'] as bool? ?? true;

        // Собираем дополнительную информацию в extra
        final Map<String, dynamic> extra = {};
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

    // Обработка простого формата ответа
    String message;
    Map<String, dynamic>? extra;
    bool isCustom = false;

    if (data is Map<String, dynamic>) {
      message = data["message"]?.toString() ??
          data["error"]?.toString() ??
          dioError.message ??
          "Unknown error";

      // Проверяем наличие errors или других дополнительных данных
      final errors = data["errors"] as Map<String, dynamic>?;
      if (errors != null) {
        extra = errors;
      }

      // Проверяем is_custom флаг на верхнем уровне
      if (data.containsKey('is_custom')) {
        isCustom = data['is_custom'] as bool? ?? false;
      }
    } else {
      message = dioError.message ?? "Unknown error";
    }

    return ApiException.create(
      statusCode: statusCode,
      message: message,
      extra: extra,
      isCustom: isCustom,
    );
  }

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}
