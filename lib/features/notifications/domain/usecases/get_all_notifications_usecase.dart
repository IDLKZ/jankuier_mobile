import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';
import 'package:jankuier_mobile/features/notifications/domain/repositories/notification_repository.dart';

@injectable
class GetAllNotificationsUseCase
    implements UseCase<Pagination<NotificationEntity>, NotificationPaginationParameter> {
  final NotificationRepository _repository;

  GetAllNotificationsUseCase(this._repository);

  @override
  Future<Either<Failure, Pagination<NotificationEntity>>> call(
      NotificationPaginationParameter params) async {
    return await _repository.getAllNotifications(params);
  }
}
