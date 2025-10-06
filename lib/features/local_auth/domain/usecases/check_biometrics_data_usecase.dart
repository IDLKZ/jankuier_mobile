import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// Параметры для биометрической аутентификации
class BiometricAuthParams extends Equatable {
  final String message;

  const BiometricAuthParams({required this.message});

  @override
  List<Object?> get props => [message];
}

/// UseCase для выполнения биометрической аутентификации
///
/// Запрашивает у пользователя подтверждение личности через биометрию
/// (отпечаток пальца, Face ID и т.д.).
@injectable
class CheckBiometricsDataUseCase implements UseCase<bool, BiometricAuthParams> {
  final LocalAuthInterface repository;

  CheckBiometricsDataUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(BiometricAuthParams params) async {
    return await repository.checkBiometricsData(params.message);
  }
}
