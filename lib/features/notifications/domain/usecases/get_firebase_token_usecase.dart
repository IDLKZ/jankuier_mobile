import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/repositories/notification_repository.dart';

@injectable
class GetFirebaseTokenUseCase implements UseCase<FirebaseNotificationEntity?, NoParams> {
  final NotificationRepository _repository;

  GetFirebaseTokenUseCase(this._repository);

  @override
  Future<Either<Failure, FirebaseNotificationEntity?>> call(NoParams params) async {
    return await _repository.getFirebaseToken();
  }
}
