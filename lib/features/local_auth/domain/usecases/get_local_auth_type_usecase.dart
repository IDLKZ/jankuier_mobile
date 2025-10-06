import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// UseCase для получения типа установленной локальной аутентификации
///
/// Возвращает строковое значение типа аутентификации, который
/// был выбран пользователем (например, "biometric", "pin", "none").
@injectable
class GetLocalAuthTypeUseCase implements UseCase<String?, NoParams> {
  final LocalAuthInterface repository;

  GetLocalAuthTypeUseCase(this.repository);

  @override
  Future<Either<Failure, String?>> call(NoParams params) async {
    return await repository.getLocalAuthType();
  }
}
