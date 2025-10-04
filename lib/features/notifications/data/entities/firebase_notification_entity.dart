import 'package:equatable/equatable.dart';

class FirebaseNotificationEntity extends Equatable {
  final int id;
  final int userId;
  final String token;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const FirebaseNotificationEntity({
    required this.id,
    required this.userId,
    required this.token,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FirebaseNotificationEntity.fromJson(Map<String, dynamic> json) {
    return FirebaseNotificationEntity(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      token: json['token'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        token,
        isActive,
        createdAt,
        updatedAt,
      ];
}

class FirebaseNotificationListEntity {
  static List<FirebaseNotificationEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => FirebaseNotificationEntity.fromJson(json))
        .toList();
  }
}
