import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_profile_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class UpdateProfileUseCase implements UseCase<UserEntity, UpdateProfileParameter> {
  final AuthRepository repository;

  UpdateProfileUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParameter params) async {
    return await repository.updateProfile(params);
  }
}