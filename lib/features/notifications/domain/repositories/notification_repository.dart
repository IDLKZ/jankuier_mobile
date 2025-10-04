import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';

abstract class NotificationRepository {
  /// Get current Firebase token for authenticated user
  Future<Either<Failure, FirebaseNotificationEntity?>> getFirebaseToken();

  /// Create or update Firebase token for authenticated user
  Future<Either<Failure, FirebaseNotificationEntity>> createOrUpdateFirebaseToken(
      FirebaseNotificationClientCreateParameter parameter);

  /// Get paginated list of notifications for authenticated user
  Future<Either<Failure, Pagination<NotificationEntity>>> getAllNotifications(
      NotificationPaginationParameter parameter);

  /// Get notification by ID
  Future<Either<Failure, NotificationEntity>> getNotificationById(int id);
}
