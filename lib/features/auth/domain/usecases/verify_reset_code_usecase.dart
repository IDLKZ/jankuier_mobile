import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

import '../../data/entities/user_reset_entity.dart';
import '../parameters/user_reset_parameter.dart';

@injectable
class VerifyResetCodeUseCase
    implements UseCase<UserCodeResetResultEntity, UserCodeResetParameter> {
  final AuthRepository repository;

  VerifyResetCodeUseCase(this.repository);

  @override
  Future<Either<Failure, UserCodeResetResultEntity>> call(
      UserCodeResetParameter params) async {
    return await repository.verifyResetCode(params);
  }
}
