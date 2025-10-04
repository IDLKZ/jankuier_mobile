import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_description_mixin.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/topic_notification_entity.dart';

class NotificationEntity extends Equatable
    with LocalizedTitleEntity, LocalizedDescriptionEntity {
  final int id;
  final int topicId;
  final int? userId;
  final String? topics;
  final bool isActive;
  @override
  final String titleRu;
  @override
  final String? titleKk;
  @override
  final String? titleEn;
  @override
  final String descriptionRu;
  @override
  final String? descriptionKk;
  @override
  final String? descriptionEn;
  final String? actionUrl;
  final String? innerActionUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final TopicNotificationEntity? topic;

  const NotificationEntity({
    required this.id,
    required this.topicId,
    this.userId,
    this.topics,
    required this.isActive,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    this.actionUrl,
    this.innerActionUrl,
    required this.createdAt,
    required this.updatedAt,
    this.topic,
  });

  factory NotificationEntity.fromJson(Map<String, dynamic> json) {
    return NotificationEntity(
      id: json['id'] ?? 0,
      topicId: json['topic_id'] ?? 0,
      userId: json['user_id'],
      topics: json['topics'],
      isActive: json['is_active'] ?? true,
      titleRu: json['title_ru'] ?? '',
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'] ?? '',
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      actionUrl: json['action_url'],
      innerActionUrl: json['inner_action_url'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      topic: json['topic'] != null
          ? TopicNotificationEntity.fromJson(json['topic'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        topicId,
        userId,
        topics,
        isActive,
        titleRu,
        titleKk,
        titleEn,
        descriptionRu,
        descriptionKk,
        descriptionEn,
        actionUrl,
        innerActionUrl,
        createdAt,
        updatedAt,
        topic,
      ];
}

class NotificationListEntity {
  static List<NotificationEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationEntity.fromJson(json)).toList();
  }
}
