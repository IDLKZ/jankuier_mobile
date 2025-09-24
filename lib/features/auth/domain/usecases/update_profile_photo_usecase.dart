import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@injectable
class UpdateProfilePhotoUseCase implements UseCase<UserEntity, File> {
  final AuthRepository repository;

  UpdateProfilePhotoUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(File params) async {
    return await repository.updateProfilePhoto(params);
  }
}