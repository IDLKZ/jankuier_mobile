import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';

import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';

abstract class NotificationDSInterface {
  Future<FirebaseNotificationEntity?> get();
  Future<FirebaseNotificationEntity> createOrUpdate(
      FirebaseNotificationClientCreateParameter parameter);
  Future<Pagination<NotificationEntity>> getAll(
      NotificationPaginationParameter parameter);
  Future<NotificationEntity> getById(int id);
}

@Injectable(as: NotificationDSInterface)
class NotificationDSImpl implements NotificationDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<FirebaseNotificationEntity> createOrUpdate(
      FirebaseNotificationClientCreateParameter parameter) async {
    try {
      final response = await httpUtils.post(
          ApiConstant.createOrUpdateMyFirebaseToken,
          data: parameter.toJson());
      final result = FirebaseNotificationEntity.fromJson(response);
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
  Future<FirebaseNotificationEntity?> get() async {
    try {
      final response = await httpUtils.get(ApiConstant.getMyFirebaseToken);
      final result = FirebaseNotificationEntity?.fromJson(response);
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
  Future<Pagination<NotificationEntity>> getAll(
      NotificationPaginationParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.paginateMyNotifications,
          queryParameters: parameter.toQueryParameters());
      final result = Pagination<NotificationEntity>.fromJson(
          response, NotificationEntity.fromJson);
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
  Future<NotificationEntity> getById(int id) async {
    try {
      final response = await httpUtils.get(ApiConstant.getNotificationById(id));
      final result = NotificationEntity.fromJson(response);
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
