import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';

import '../../../../core/common/entities/file_entity.dart';

class TopicNotificationEntity extends Equatable with LocalizedTitleEntity {
  final int id;
  final int? imageId;
  @override
  final String titleRu;
  @override
  final String? titleKk;
  @override
  final String? titleEn;
  final String value;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FileEntity? image;

  const TopicNotificationEntity({
    required this.id,
    this.imageId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory TopicNotificationEntity.fromJson(Map<String, dynamic> json) {
    return TopicNotificationEntity(
      id: json['id'] ?? 0,
      imageId: json['image_id'],
      titleRu: json['title_ru'] ?? '',
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      value: json['value'] ?? '',
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageId,
        titleRu,
        titleKk,
        titleEn,
        value,
        createdAt,
        updatedAt,
        image,
      ];
}

class TopicNotificationListEntity {
  static List<TopicNotificationEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => TopicNotificationEntity.fromJson(json))
        .toList();
  }
}
