import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/notification_entity.dart';

abstract class GetAllNotificationsState extends Equatable {
  const GetAllNotificationsState();

  @override
  List<Object?> get props => [];
}

class AllNotificationsInitial extends GetAllNotificationsState {
  const AllNotificationsInitial();
}

class AllNotificationsLoading extends GetAllNotificationsState {
  const AllNotificationsLoading();
}

class AllNotificationsLoaded extends GetAllNotificationsState {
  final Pagination<NotificationEntity> notifications;

  const AllNotificationsLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class AllNotificationsError extends GetAllNotificationsState {
  final String message;

  const AllNotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}
