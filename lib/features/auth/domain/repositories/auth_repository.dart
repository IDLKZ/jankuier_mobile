import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/register_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/send_verify_code_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_password_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_profile_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/user_verification_parameter.dart';

abstract class AuthRepository {
  Future<Either<Failure, BearerTokenEntity>> signIn(LoginParameter parameter);
  Future<Either<Failure, UserEntity>> signUp(RegisterParameter parameter);
  Future<Either<Failure, UserEntity>> me();
  Future<Either<Failure, bool>> updatePassword(
      UpdatePasswordParameter parameter);
  Future<Either<Failure, UserEntity>> updateProfile(
      UpdateProfileParameter parameter);
  Future<Either<Failure, UserEntity>> updateProfilePhoto(File file);
  Future<Either<Failure, UserEntity>> deleteProfilePhoto();
  Future<Either<Failure, UserCodeVerificationResultEntity>> sendVerifyCode(
      String phone);
  Future<Either<Failure, UserCodeVerificationResultEntity>> verifyCode(
      UserCodeVerificationParameter parameter);
  Future<Either<Failure, bool>> deleteAccount();
}
