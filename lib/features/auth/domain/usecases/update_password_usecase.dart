import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_password_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class UpdatePasswordUseCase implements UseCase<bool, UpdatePasswordParameter> {
  final AuthRepository repository;

  UpdatePasswordUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(UpdatePasswordParameter params) async {
    return await repository.updatePassword(params);
  }
}