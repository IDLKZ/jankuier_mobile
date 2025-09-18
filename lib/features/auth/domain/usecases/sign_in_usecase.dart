import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignInUseCase implements UseCase<BearerTokenEntity, LoginParameter> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, BearerTokenEntity>> call(LoginParameter params) async {
    return await repository.signIn(params);
  }
}