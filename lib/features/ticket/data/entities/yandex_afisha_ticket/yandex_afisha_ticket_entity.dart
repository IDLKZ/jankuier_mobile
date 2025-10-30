import 'package:equatable/equatable.dart';

import '../../../../../core/common/entities/file_entity.dart';

class YandexAfishaWidgetTicketEntity extends Equatable {
  final int id;
  final int? imageId;
  final String titleRu;
  final String? titleKk;
  final String? titleEn;
  final String? descriptionRu;
  final String? descriptionKk;
  final String? descriptionEn;
  final String? addressRu;
  final String? addressKk;
  final String? addressEn;
  final String? stadiumRu;
  final String? stadiumKk;
  final String? stadiumEn;
  final DateTime? startAt;
  final String yandexSessionId;
  final String? yandexWidgetUrl;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final FileEntity? image;

  const YandexAfishaWidgetTicketEntity({
    required this.id,
    this.imageId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    this.addressRu,
    this.addressKk,
    this.addressEn,
    this.stadiumRu,
    this.stadiumKk,
    this.stadiumEn,
    this.startAt,
    required this.yandexSessionId,
    this.yandexWidgetUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.image,
  });

  factory YandexAfishaWidgetTicketEntity.fromJson(Map<String, dynamic> json) {
    return YandexAfishaWidgetTicketEntity(
      id: json['id'] ?? 0,
      imageId: json['image_id'],
      titleRu: json['title_ru'] ?? '',
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      addressRu: json['address_ru'],
      addressKk: json['address_kk'],
      addressEn: json['address_en'],
      stadiumRu: json['stadium_ru'],
      stadiumKk: json['stadium_kk'],
      stadiumEn: json['stadium_en'],
      startAt:
          json['start_at'] != null ? DateTime.tryParse(json['start_at']) : null,
      yandexSessionId: json['yandex_session_id'] ?? '',
      yandexWidgetUrl: json['yandex_widget_url'],
      isActive: json['is_active'] ?? false,
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
        descriptionRu,
        descriptionKk,
        descriptionEn,
        addressRu,
        addressKk,
        addressEn,
        stadiumRu,
        stadiumKk,
        stadiumEn,
        startAt,
        yandexSessionId,
        yandexWidgetUrl,
        isActive,
        createdAt,
        updatedAt,
        image,
      ];
}

class YandexAfishaWidgetTicketListEntity {
  static List<YandexAfishaWidgetTicketEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => YandexAfishaWidgetTicketEntity.fromJson(json))
        .toList();
  }
}
