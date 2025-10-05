import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/refresh_token_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class RefreshTokenUseCase
    implements UseCase<BearerTokenEntity, RefreshTokenParameter> {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  @override
  Future<Either<Failure, BearerTokenEntity>> call(
      RefreshTokenParameter params) async {
    return await repository.refreshToken(params);
  }
}
