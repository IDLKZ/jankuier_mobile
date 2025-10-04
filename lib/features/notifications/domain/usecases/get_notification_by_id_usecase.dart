import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/repositories/notification_repository.dart';

@injectable
class GetNotificationByIdUseCase implements UseCase<NotificationEntity, int> {
  final NotificationRepository _repository;

  GetNotificationByIdUseCase(this._repository);

  @override
  Future<Either<Failure, NotificationEntity>> call(int params) async {
    return await _repository.getNotificationById(params);
  }
}
