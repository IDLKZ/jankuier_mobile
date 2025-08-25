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
    final message = data?["message"] ?? dioError.message ?? "Unknown error";
    final errors = data?["errors"] as Map<String, dynamic>?;

    return ApiException.create(
      statusCode: statusCode,
      message: message.toString(),
      extra: errors,
    );
  }

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'ApiException(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}
