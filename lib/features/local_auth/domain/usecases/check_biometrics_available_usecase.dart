import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:local_auth/local_auth.dart';
import '../repository/local_auth_interface.dart';

/// UseCase для проверки доступности биометрической аутентификации
///
/// Определяет, поддерживает ли устройство биометрическую аутентификацию
/// и возвращает список доступных типов биометрии.
@injectable
class CheckBiometricsAvailableUseCase
    implements UseCase<List<BiometricType>?, NoParams> {
  final LocalAuthInterface repository;

  CheckBiometricsAvailableUseCase(this.repository);

  @override
  Future<Either<Failure, List<BiometricType>?>> call(NoParams params) async {
    return await repository.checkBiometricsAvailable();
  }
}
