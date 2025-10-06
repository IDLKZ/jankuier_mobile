import 'package:equatable/equatable.dart';
import 'package:local_auth/local_auth.dart';

abstract class LocalAuthState extends Equatable {
  const LocalAuthState();

  @override
  List<Object?> get props => [];
}

/// Начальное состояние
class LocalAuthInitial extends LocalAuthState {
  const LocalAuthInitial();
}

/// Состояние загрузки
class LocalAuthLoading extends LocalAuthState {
  const LocalAuthLoading();
}

/// Биометрия доступна
class BiometricsAvailable extends LocalAuthState {
  final List<BiometricType>? biometricTypes;

  const BiometricsAvailable(this.biometricTypes);

  @override
  List<Object?> get props => [biometricTypes];
}

/// Биометрия недоступна
class BiometricsNotAvailable extends LocalAuthState {
  const BiometricsNotAvailable();
}

/// Успешная аутентификация
class AuthenticationSuccess extends LocalAuthState {
  const AuthenticationSuccess();
}

/// Ошибка аутентификации
class AuthenticationFailure extends LocalAuthState {
  final String message;

  const AuthenticationFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Успешная проверка PIN-кода
class PinCheckSuccess extends LocalAuthState {
  const PinCheckSuccess();
}

/// Ошибка проверки PIN-кода
class PinCheckFailure extends LocalAuthState {
  const PinCheckFailure();
}

/// PIN-код успешно установлен
class PinSetSuccess extends LocalAuthState {
  const PinSetSuccess();
}

/// Ошибка установки PIN-кода
class PinSetFailure extends LocalAuthState {
  final String message;

  const PinSetFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// PIN-код существует
class PinExists extends LocalAuthState {
  const PinExists();
}

/// PIN-код не существует
class PinNotExists extends LocalAuthState {
  const PinNotExists();
}

/// PIN-код успешно обновлен
class PinUpdated extends LocalAuthState {
  const PinUpdated();
}

/// Ошибка обновления PIN-кода
class PinUpdateFailure extends LocalAuthState {
  final String message;

  const PinUpdateFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Тип аутентификации загружен
class AuthTypeLoaded extends LocalAuthState {
  final String? authType;

  const AuthTypeLoaded(this.authType);

  @override
  List<Object?> get props => [authType];
}

/// Тип аутентификации установлен
class AuthTypeSet extends LocalAuthState {
  const AuthTypeSet();
}

/// Ошибка установки типа аутентификации
class AuthTypeSetFailure extends LocalAuthState {
  final String message;

  const AuthTypeSetFailure(this.message);

  @override
  List<Object?> get props => [message];
}

/// Общая ошибка
class LocalAuthError extends LocalAuthState {
  final String message;

  const LocalAuthError(this.message);

  @override
  List<Object?> get props => [message];
}
