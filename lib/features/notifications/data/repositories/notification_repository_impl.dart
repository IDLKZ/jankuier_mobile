import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/notifications/data/datasources/notification_datasource.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/repositories/notification_repository.dart';

@Injectable(as: NotificationRepository)
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationDSInterface _dataSource;

  NotificationRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, FirebaseNotificationEntity?>> getFirebaseToken() async {
    try {
      final result = await _dataSource.get();
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FirebaseNotificationEntity>> createOrUpdateFirebaseToken(
      FirebaseNotificationClientCreateParameter parameter) async {
    try {
      final result = await _dataSource.createOrUpdate(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<NotificationEntity>>> getAllNotifications(
      NotificationPaginationParameter parameter) async {
    try {
      final result = await _dataSource.getAll(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, NotificationEntity>> getNotificationById(int id) async {
    try {
      final result = await _dataSource.getById(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
