import 'package:equatable/equatable.dart';

import 'notification_entity.dart';

class ReadNotificationEntity extends Equatable {
  final int id;
  final int notificationId;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final NotificationEntity? notification;

  const ReadNotificationEntity({
    required this.id,
    required this.notificationId,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    this.notification,
  });

  factory ReadNotificationEntity.fromJson(Map<String, dynamic> json) {
    return ReadNotificationEntity(
      id: json['id'] ?? 0,
      notificationId: json['notification_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      notification: json['notification'] != null
          ? NotificationEntity.fromJson(json['notification'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        notificationId,
        userId,
        createdAt,
        updatedAt,
        notification,
      ];
}

class ReadNotificationListEntity {
  static List<ReadNotificationEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ReadNotificationEntity.fromJson(json))
        .toList();
  }
}
