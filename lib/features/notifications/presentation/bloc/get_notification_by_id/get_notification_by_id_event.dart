import 'package:equatable/equatable.dart';

abstract class GetNotificationByIdEvent extends Equatable {
  const GetNotificationByIdEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotificationById extends GetNotificationByIdEvent {
  final int id;

  const LoadNotificationById(this.id);

  @override
  List<Object?> get props => [id];
}
