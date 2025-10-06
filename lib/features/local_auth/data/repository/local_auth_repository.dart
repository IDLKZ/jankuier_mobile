import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/constants/app_constants.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/local_auth/domain/repository/local_auth_interface.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/constants/local_auth_constants.dart';

/// Репозиторий для локальной аутентификации
///
/// Реализует интерфейс [LocalAuthInterface] и предоставляет методы для:
/// - Биометрической аутентификации (отпечаток пальца, Face ID)
/// - PIN-кода аутентификации
/// - Управления настройками локальной аутентификации
///
/// Использует:
/// - [LocalAuthentication] для биометрической аутентификации
/// - [FlutterSecureStorage] для безопасного хранения PIN-кода
@Injectable(as: LocalAuthInterface)
class LocalAuthRepositoryImpl implements LocalAuthInterface {
  /// Экземпляр LocalAuthentication для работы с биометрией
  final LocalAuthentication auth = LocalAuthentication();

  /// Безопасное хранилище для PIN-кода и настроек аутентификации
  final _storage = const FlutterSecureStorage();

  /// Проверяет доступность биометрической аутентификации на устройстве
  ///
  /// Определяет, поддерживает ли устройство биометрическую аутентификацию
  /// и возвращает список доступных типов биометрии.
  ///
  /// **Возвращает:**
  /// - [Right] со списком [BiometricType] если биометрия доступна
  /// - [Right] с null если биометрия не поддерживается
  /// - [Left] с [ServerFailure] при возникновении ошибки
  ///
  /// **Примеры типов биометрии:**
  /// - [BiometricType.face] - Face ID / распознавание лица
  /// - [BiometricType.fingerprint] - отпечаток пальца
  /// - [BiometricType.iris] - сканирование радужки глаза
  @override
  Future<Either<Failure, List<BiometricType>?>>
      checkBiometricsAvailable() async {
    try {
      List<BiometricType>? availableMethods;
      // Проверяем, может ли устройство использовать биометрию
      final bool canAuthenticate =
          await auth.canCheckBiometrics || await auth.isDeviceSupported();
      if (canAuthenticate) {
        // Получаем список доступных методов биометрии
        availableMethods = await auth.getAvailableBiometrics();
      }
      if (availableMethods == null) {
        await this.setLocalAuthType(LocalAuthConstants.PINTYPE);
      }
      return Right(availableMethods);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Выполняет биометрическую аутентификацию пользователя
  ///
  /// Запрашивает у пользователя подтверждение личности через биометрию
  /// (отпечаток пальца, Face ID и т.д.).
  ///
  /// **Параметры:**
  /// - [message] - локализованное сообщение, объясняющее причину запроса биометрии
  ///
  /// **Возвращает:**
  /// - [Right(true)] если аутентификация успешна
  /// - [Right(false)] если биометрия недоступна или пользователь отменил
  /// - [Left] с [ServerFailure] при возникновении ошибки
  ///
  /// **Настройки аутентификации:**
  /// - `biometricOnly: true` - только биометрия, без PIN/пароля устройства
  /// - `stickyAuth: true` - диалог остается открытым при переключении приложений
  /// - `useErrorDialogs: true` - показывать системные диалоги ошибок
  @override
  Future<Either<Failure, bool>> checkBiometricsData(String message) async {
    try {
      // Проверяем доступность биометрии на устройстве
      final canCheck = await auth.canCheckBiometrics;
      final isDeviceSupported = await auth.isDeviceSupported();
      if (!canCheck || !isDeviceSupported) {
        return Right(false);
      }
      // Запускаем процесс биометрической аутентификации
      final didAuthenticate = await auth.authenticate(
        localizedReason: message,
        options: const AuthenticationOptions(
          biometricOnly: true, // Только биометрия
          stickyAuth: true, // Не закрывать при переключении приложений
          useErrorDialogs: true, // Показывать системные ошибки
        ),
      );
      if (didAuthenticate) {
        await this.setLocalAuthType(LocalAuthConstants.BiometricType);
      } else {
        await this.setLocalAuthType(LocalAuthConstants.PINTYPE);
      }
      return Right(didAuthenticate);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Проверяет введенный PIN-код на соответствие сохраненному
  ///
  /// Сравнивает переданный PIN-код с сохраненным в безопасном хранилище.
  ///
  /// **Параметры:**
  /// - [pin] - введенный пользователем PIN-код для проверки
  ///
  /// **Возвращает:**
  /// - [Right(true)] если PIN-код совпадает с сохраненным
  /// - [Right(false)] если PIN-код не совпадает или не был установлен
  /// - [Left] с [ServerFailure] при возникновении ошибки
  @override
  Future<Either<Failure, bool>> checkPinCode(String pin) async {
    try {
      // Читаем сохраненный PIN-код из безопасного хранилища
      final String? storedPin =
          await _storage.read(key: LocalAuthConstants.localAuthKey);
      if (storedPin != null) {
        if (pin == storedPin) {
          return Right(true);
        }
      }
      return Right(false);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Устанавливает новый PIN-код в безопасное хранилище
  ///
  /// Сохраняет PIN-код только если он еще не был установлен ранее.
  ///
  /// **Параметры:**
  /// - [pin] - новый PIN-код для сохранения
  ///
  /// **Возвращает:**
  /// - [Right(true)] если PIN-код успешно сохранен
  /// - [Right(false)] если PIN-код уже был установлен ранее
  /// - [Left] с [ServerFailure] при возникновении ошибки
  ///
  /// **Примечание:** Для обновления существующего PIN-кода используйте [reloadPinCode]
  @override
  Future<Either<Failure, bool>> setPinHash(String pin) async {
    try {
      // Проверяем, не был ли PIN-код установлен ранее
      final String? storedPin =
          await _storage.read(key: LocalAuthConstants.localAuthKey);
      if (storedPin != null) {
        return Right(false); // PIN уже существует
      }
      // Сохраняем новый PIN-код
      await _storage.write(key: LocalAuthConstants.localAuthKey, value: pin);
      await this.setLocalAuthType(LocalAuthConstants.PINTYPE);
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Проверяет, был ли ранее установлен PIN-код
  ///
  /// Используется для определения, нужно ли показывать экран
  /// установки PIN-кода или экран входа по PIN-коду.
  ///
  /// **Возвращает:**
  /// - [Right(true)] если PIN-код был установлен ранее
  /// - [Right(false)] если PIN-код еще не установлен
  /// - [Left] с [ServerFailure] при возникновении ошибки
  @override
  Future<Either<Failure, bool>> getPinHashBefore() async {
    try {
      final String? storedPin =
          await _storage.read(key: LocalAuthConstants.localAuthKey);
      if (storedPin != null) {
        return Right(true);
      }
      return Right(false);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Обновляет существующий PIN-код на новый
  ///
  /// Для успешного обновления необходимо подтвердить старый PIN-код.
  ///
  /// **Параметры:**
  /// - [oldPin] - текущий PIN-код для подтверждения
  /// - [pin] - новый PIN-код для установки
  ///
  /// **Возвращает:**
  /// - [Right(true)] если старый PIN верен и новый успешно сохранен
  /// - [Right(false)] если старый PIN неверен или не был установлен
  /// - [Left] с [ServerFailure] при возникновении ошибки
  @override
  Future<Either<Failure, bool>> reloadPinCode(String oldPin, String pin) async {
    try {
      // Читаем текущий PIN-код
      final String? storedPin =
          await _storage.read(key: LocalAuthConstants.localAuthKey);
      if (storedPin != null) {
        // Проверяем соответствие старого PIN-кода
        if (oldPin == storedPin) {
          // Обновляем PIN-код на новый
          await _storage.write(
              key: LocalAuthConstants.localAuthKey, value: pin);
          return Right(true);
        }
      }
      return Right(false);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Получает тип установленной локальной аутентификации
  ///
  /// Возвращает строковое значение типа аутентификации, который
  /// был выбран пользователем (например, "biometric", "pin", "none").
  ///
  /// **Возвращает:**
  /// - [Right] со строкой типа аутентификации или null если не установлен
  /// - [Left] с [ServerFailure] при возникновении ошибки
  @override
  Future<Either<Failure, String?>> getLocalAuthType() async {
    try {
      final String? localAuthType =
          await _storage.read(key: LocalAuthConstants.getTypeLocalAuth);
      return Right(localAuthType);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  /// Устанавливает тип локальной аутентификации
  ///
  /// Сохраняет выбранный пользователем тип аутентификации
  /// для последующего использования при входе в приложение.
  ///
  /// **Параметры:**
  /// - [pinType] - тип аутентификации (например: "biometric", "pin", "none")
  ///
  /// **Возвращает:**
  /// - [Right(true)] если тип успешно сохранен
  /// - [Left] с [ServerFailure] при возникновении ошибки
  @override
  Future<Either<Failure, bool>> setLocalAuthType(String pinType) async {
    try {
      await _storage.write(
          key: LocalAuthConstants.getTypeLocalAuth, value: pinType);
      return Right(true);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
