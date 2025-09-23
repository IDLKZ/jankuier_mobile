import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

import '../../data/entities/user_verification_entity.dart';

@injectable
class SendVerifyCodeUseCase
    implements UseCase<UserCodeVerificationResultEntity, String> {
  final AuthRepository repository;

  SendVerifyCodeUseCase(this.repository);

  @override
  Future<Either<Failure, UserCodeVerificationResultEntity>> call(
      String phone) async {
    return await repository.sendVerifyCode(phone);
  }
}
