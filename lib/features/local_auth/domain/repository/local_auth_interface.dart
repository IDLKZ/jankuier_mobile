import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:local_auth/local_auth.dart';

abstract class LocalAuthInterface {
  //Проверка  доступности FaceId или TouchId
  Future<Either<Failure, String?>> getLocalAuthType();
  Future<Either<Failure, bool>> setLocalAuthType(String pinType);
  Future<Either<Failure, List<BiometricType>?>> checkBiometricsAvailable();
  Future<Either<Failure, bool>> checkBiometricsData(String message);
  Future<Either<Failure, bool>> setPinHash(String pin);
  Future<Either<Failure, bool>> getPinHashBefore();
  Future<Either<Failure, bool>> checkPinCode(String pin);
  Future<Either<Failure, bool>> reloadPinCode(String pin);
}
