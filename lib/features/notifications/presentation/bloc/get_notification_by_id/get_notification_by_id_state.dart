import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';

abstract class GetNotificationByIdState extends Equatable {
  const GetNotificationByIdState();

  @override
  List<Object?> get props => [];
}

class NotificationByIdInitial extends GetNotificationByIdState {
  const NotificationByIdInitial();
}

class NotificationByIdLoading extends GetNotificationByIdState {
  const NotificationByIdLoading();
}

class NotificationByIdLoaded extends GetNotificationByIdState {
  final NotificationEntity notification;

  const NotificationByIdLoaded(this.notification);

  @override
  List<Object?> get props => [notification];
}

class NotificationByIdError extends GetNotificationByIdState {
  final String message;

  const NotificationByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
