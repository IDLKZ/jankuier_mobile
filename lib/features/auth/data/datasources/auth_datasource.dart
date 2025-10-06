import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/refresh_token_parameter.dart';
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
  Future<BearerTokenEntity> refreshToken(RefreshTokenParameter parameter);
  Future<bool> updatePassword(UpdatePasswordParameter parameter);
  Future<UserEntity> updateProfile(UpdateProfileParameter parameter);
  Future<UserEntity> updateProfilePhoto(File file);
  Future<UserEntity> deleteProfilePhoto();
  Future<UserCodeVerificationResultEntity> sendVerifyCode(String phone);
  Future<UserCodeVerificationResultEntity> verifyCode(
      UserCodeVerificationParameter parameter);
  Future<bool> deleteAccount();
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
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
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserEntity> updateProfilePhoto(File file) async {
    try {
      String fileName = file.path.split('/').last;

      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(
          file.path,
          filename: fileName, // можно указать своё имя
        ),
      });
      final response = await httpUtils
          .put(ApiConstant.UpdateProfilePhoto, data: formData, headers: {
        "Content-Type": "multipart/form-data",
      });
      final result = UserEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<UserEntity> deleteProfilePhoto() async {
    try {
      final response =
          await httpUtils.delete(ApiConstant.DeleteProfilePhotoUrl);
      final result = UserEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<bool> deleteAccount() async {
    try {
      final response = await httpUtils.delete(ApiConstant.DeleteAccountUrl);
      return response ?? true;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<BearerTokenEntity> refreshToken(
      RefreshTokenParameter parameter) async {
    try {
      final response = await httpUtils.post(ApiConstant.RefreshTokenUrl,
          data: parameter.toJson());
      final result = BearerTokenEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
