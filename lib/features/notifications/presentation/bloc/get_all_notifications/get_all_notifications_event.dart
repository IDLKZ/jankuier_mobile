import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/notification_pagination_parameter.dart';

abstract class GetAllNotificationsEvent extends Equatable {
  const GetAllNotificationsEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllNotifications extends GetAllNotificationsEvent {
  final NotificationPaginationParameter parameter;

  const LoadAllNotifications(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class RefreshNotifications extends GetAllNotificationsEvent {
  final NotificationPaginationParameter parameter;

  const RefreshNotifications(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
