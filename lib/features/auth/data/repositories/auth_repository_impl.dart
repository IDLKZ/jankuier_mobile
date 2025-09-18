import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/register_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_password_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_profile_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDSInterface _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, BearerTokenEntity>> signIn(LoginParameter parameter) async {
    try {
      final result = await _dataSource.signIn(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUp(RegisterParameter parameter) async {
    try {
      final result = await _dataSource.signUp(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> me() async {
    try {
      final result = await _dataSource.me();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> updatePassword(UpdatePasswordParameter parameter) async {
    try {
      final result = await _dataSource.updatePassword(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> updateProfile(UpdateProfileParameter parameter) async {
    try {
      final result = await _dataSource.updateProfile(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}