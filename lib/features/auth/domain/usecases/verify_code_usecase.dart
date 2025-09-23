import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/user_verification_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class VerifyCodeUseCase
    implements
        UseCase<UserCodeVerificationResultEntity,
            UserCodeVerificationParameter> {
  final AuthRepository repository;

  VerifyCodeUseCase(this.repository);

  @override
  Future<Either<Failure, UserCodeVerificationResultEntity>> call(
      UserCodeVerificationParameter params) async {
    return await repository.verifyCode(params);
  }
}
