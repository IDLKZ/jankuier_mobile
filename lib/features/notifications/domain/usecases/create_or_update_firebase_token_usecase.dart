import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/repositories/notification_repository.dart';

@injectable
class CreateOrUpdateFirebaseTokenUseCase
    implements UseCase<FirebaseNotificationEntity, FirebaseNotificationClientCreateParameter> {
  final NotificationRepository _repository;

  CreateOrUpdateFirebaseTokenUseCase(this._repository);

  @override
  Future<Either<Failure, FirebaseNotificationEntity>> call(
      FirebaseNotificationClientCreateParameter params) async {
    return await _repository.createOrUpdateFirebaseToken(params);
  }
}
