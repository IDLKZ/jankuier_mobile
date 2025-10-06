import 'package:equatable/equatable.dart';

abstract class LocalAuthEvent extends Equatable {
  const LocalAuthEvent();

  @override
  List<Object?> get props => [];
}

/// Событие для проверки доступности биометрической аутентификации
class CheckBiometricsAvailable extends LocalAuthEvent {
  const CheckBiometricsAvailable();
}

/// Событие для аутентификации через биометрию
class AuthenticateWithBiometrics extends LocalAuthEvent {
  final String message;

  const AuthenticateWithBiometrics({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Событие для проверки PIN-кода
class CheckPinCode extends LocalAuthEvent {
  final String pin;

  const CheckPinCode({required this.pin});

  @override
  List<Object?> get props => [pin];
}

/// Событие для установки PIN-кода
class SetPinCode extends LocalAuthEvent {
  final String pin;

  const SetPinCode({required this.pin});

  @override
  List<Object?> get props => [pin];
}

/// Событие для проверки наличия установленного PIN-кода
class CheckPinExists extends LocalAuthEvent {
  const CheckPinExists();
}

/// Событие для обновления PIN-кода
class UpdatePinCode extends LocalAuthEvent {
  final String oldPin;
  final String newPin;

  const UpdatePinCode({required this.oldPin, required this.newPin});

  @override
  List<Object?> get props => [oldPin, newPin];
}

/// Событие для получения типа локальной аутентификации
class GetAuthType extends LocalAuthEvent {
  const GetAuthType();
}

/// Событие для установки типа локальной аутентификации
class SetAuthType extends LocalAuthEvent {
  final String authType;

  const SetAuthType({required this.authType});

  @override
  List<Object?> get props => [authType];
}
