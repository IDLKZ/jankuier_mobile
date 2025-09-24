import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';

import '../repositories/auth_repository.dart';

@injectable
class DeleteProfilePhotoUseCase implements UseCase<UserEntity, NoParams> {
  final AuthRepository repository;

  DeleteProfilePhotoUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) async {
    return await repository.deleteProfilePhoto();
  }
}
