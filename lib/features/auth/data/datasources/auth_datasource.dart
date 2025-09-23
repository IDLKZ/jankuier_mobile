import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/register_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_password_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_profile_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/user_verification_parameter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../entities/user_entity.dart';

abstract class AuthDSInterface {
  Future<BearerTokenEntity> signIn(LoginParameter parameter);
  Future<UserEntity> signUp(RegisterParameter parameter);
  Future<UserEntity> me();
  Future<bool> updatePassword(UpdatePasswordParameter parameter);
  Future<UserEntity> updateProfile(UpdateProfileParameter parameter);
  Future<UserCodeVerificationResultEntity> sendVerifyCode(String phone);
  Future<UserCodeVerificationResultEntity> verifyCode(
      UserCodeVerificationParameter parameter);
}

@Injectable(as: AuthDSInterface)
class AuthDSImpl implements AuthDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<UserEntity> me() async {
    try {
      final response = await httpUtils.get(ApiConstant.GetMeUrl);
      final result = UserEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<BearerTokenEntity> signIn(LoginParameter parameter) async {
    try {
      final response =
          await httpUtils.post(ApiConstant.LoginUrl, data: parameter.toJson());
      final result = BearerTokenEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserEntity> signUp(RegisterParameter parameter) async {
    try {
      final response = await httpUtils.post(ApiConstant.RegisterUrl,
          data: parameter.toJson());
      final result = UserEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<bool> updatePassword(UpdatePasswordParameter parameter) async {
    try {
      final response = await httpUtils.post(ApiConstant.UpdatePasswordUrl,
          data: parameter.toJson());
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserEntity> updateProfile(UpdateProfileParameter parameter) async {
    try {
      final response = await httpUtils.post(ApiConstant.UpdateProfileUrl,
          data: parameter.toJson());
      final result = UserEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserCodeVerificationResultEntity> sendVerifyCode(String phone) async {
    try {
      final response = await httpUtils
          .post(ApiConstant.SendVerificationCodeUrl, data: {"phone": phone});
      final result = UserCodeVerificationResultEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserCodeVerificationResultEntity> verifyCode(
      UserCodeVerificationParameter parameter) async {
    try {
      final response = await httpUtils.post(ApiConstant.VerifyCodeUrl,
          data: parameter.toJson());
      final result = UserCodeVerificationResultEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
