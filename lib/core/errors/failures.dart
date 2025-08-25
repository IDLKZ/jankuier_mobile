import 'package:equatable/equatable.dart';
import 'exception.dart';

abstract class Failure extends Equatable {
  const Failure({
    this.message,
    this.statusCode,
    this.extra,
    this.isCustom = true,
  });

  final String? message;
  final int? statusCode;
  final Map<String, dynamic>? extra;
  final bool isCustom;
}

class ApiFailure extends Failure {
  const ApiFailure({
    super.message,
    super.statusCode,
    super.extra,
    super.isCustom,
  });

  // Конструктор из ApiException
  ApiFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
          extra: exception.extra,
          isCustom: exception.isCustom,
        );

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'ApiFailure(statusCode: $statusCode, message: $message, extra: $extra, isCustom: $isCustom)';
  }
}

class CacheFailure extends Failure {
  const CacheFailure({
    super.message,
    super.statusCode,
    super.extra,
    super.isCustom = false,
  });

  // Если у вас есть CacheException, добавьте этот конструктор
  // CacheFailure.fromException(CacheException exception)
  //     : this(
  //         message: exception.message,
  //         statusCode: exception.statusCode,
  //         extra: exception.extra,
  //         isCustom: exception.isCustom,
  //       );

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'CacheFailure(statusCode: $statusCode, message: $message, extra: $extra, isCustom: $isCustom)';
  }
}

// Дополнительные типы Failure, которые могут пригодиться
class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'Network connection error',
    super.statusCode,
    super.extra,
    super.isCustom = false,
  });

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'NetworkFailure(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}

class AuthFailure extends Failure {
  const AuthFailure({
    super.message = 'Authentication failed',
    super.statusCode = 401,
    super.extra,
    super.isCustom = false,
  });

  AuthFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
          extra: exception.extra,
          isCustom: exception.isCustom,
        );

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'AuthFailure(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}

class ValidationFailure extends Failure {
  const ValidationFailure({
    super.message = 'Validation error',
    super.statusCode = 422,
    super.extra,
    super.isCustom = false,
  });

  ValidationFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
          extra: exception.extra,
          isCustom: exception.isCustom,
        );

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'ValidationFailure(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}

class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'Server error',
    super.statusCode = 500,
    super.extra,
    super.isCustom = false,
  });

  ServerFailure.fromException(ApiException exception)
      : this(
          message: exception.message,
          statusCode: exception.statusCode,
          extra: exception.extra,
          isCustom: exception.isCustom,
        );

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'ServerFailure(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}

class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'Unknown error',
    super.statusCode,
    super.extra,
    super.isCustom = false,
  });

  @override
  List<Object?> get props => [message, statusCode, extra, isCustom];

  @override
  String toString() {
    return 'UnknownFailure(statusCode: $statusCode, message: $message, extra: $extra)';
  }
}

// Утилита для преобразования ApiException в соответствующий Failure
class FailureMapper {
  static Failure fromApiException(ApiException exception) {
    switch (exception.statusCode) {
      case 401:
        return AuthFailure.fromException(exception);
      case 422:
        return ValidationFailure.fromException(exception);
      case >= 500:
        return ServerFailure.fromException(exception);
      default:
        return ApiFailure.fromException(exception);
    }
  }
}

// Расширение для удобного получения конкретных типов ошибок из extra
extension FailureExtension on Failure {
  // Получить конкретную ошибку поля из extra
  String? getFieldError(String fieldName) {
    if (extra == null) return null;

    final fieldErrors = extra![fieldName];
    if (fieldErrors is List && fieldErrors.isNotEmpty) {
      return fieldErrors.first.toString();
    } else if (fieldErrors is String) {
      return fieldErrors;
    }

    return null;
  }

  // Получить все ошибки полей как Map
  Map<String, String> getAllFieldErrors() {
    if (extra == null) return {};

    final Map<String, String> errors = {};

    for (final entry in extra!.entries) {
      final key = entry.key;
      final value = entry.value;

      if (value is List && value.isNotEmpty) {
        errors[key] = value.first.toString();
      } else if (value is String) {
        errors[key] = value;
      }
    }

    return errors;
  }

  // Проверить, является ли ошибка сетевой
  bool get isNetworkError {
    return statusCode == null || statusCode == 0;
  }

  // Проверить, является ли ошибка авторизации
  bool get isAuthError {
    return statusCode == 401;
  }

  // Проверить, является ли ошибка валидации
  bool get isValidationError {
    return statusCode == 422;
  }

  // Проверить, является ли ошибка сервера
  bool get isServerError {
    return statusCode != null && statusCode! >= 500;
  }
}
