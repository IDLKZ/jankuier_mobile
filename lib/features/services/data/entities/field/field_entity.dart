import 'package:equatable/equatable.dart';
import '../../../../../core/common/entities/city_entity.dart';
import '../../../../../core/common/entities/file_entity.dart';

class FieldEntity extends Equatable {
  final int id;
  final int? imageId;
  final int? cityId;

  final String titleRu;
  final String? titleKk;
  final String? titleEn;

  final String? descriptionRu;
  final String? descriptionKk;
  final String? descriptionEn;

  final String value;

  final String? addressRu;
  final String? addressEn;
  final String? addressKk;

  final String? latitude;
  final String? longitude;

  final bool isActive;
  final bool hasCover;

  final String? phone;
  final String? additionalPhone;
  final String? email;
  final String? whatsapp;
  final String? telegram;
  final String? instagram;
  final String? tiktok;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final FileEntity? image;
  final CityEntity? city;

  const FieldEntity({
    required this.id,
    this.imageId,
    this.cityId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    required this.value,
    this.addressRu,
    this.addressEn,
    this.addressKk,
    this.latitude,
    this.longitude,
    this.isActive = true,
    this.hasCover = false,
    this.phone,
    this.additionalPhone,
    this.email,
    this.whatsapp,
    this.telegram,
    this.instagram,
    this.tiktok,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.image,
    this.city,
  });

  factory FieldEntity.fromJson(Map<String, dynamic> json) {
    return FieldEntity(
      id: json['id'],
      imageId: json['image_id'],
      cityId: json['city_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      value: json['value'],
      addressRu: json['address_ru'],
      addressEn: json['address_en'],
      addressKk: json['address_kk'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isActive: json['is_active'] ?? true,
      hasCover: json['has_cover'] ?? false,
      phone: json['phone'],
      additionalPhone: json['additional_phone'],
      email: json['email'],
      whatsapp: json['whatsapp'],
      telegram: json['telegram'],
      instagram: json['instagram'],
      tiktok: json['tiktok'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
      city: json['city'] != null ? CityEntity.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_id': imageId,
      'city_id': cityId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'description_ru': descriptionRu,
      'description_kk': descriptionKk,
      'description_en': descriptionEn,
      'value': value,
      'address_ru': addressRu,
      'address_en': addressEn,
      'address_kk': addressKk,
      'latitude': latitude,
      'longitude': longitude,
      'is_active': isActive,
      'has_cover': hasCover,
      'phone': phone,
      'additional_phone': additionalPhone,
      'email': email,
      'whatsapp': whatsapp,
      'telegram': telegram,
      'instagram': instagram,
      'tiktok': tiktok,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'image': image?.toJson(),
      'city': city?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        imageId,
        cityId,
        titleRu,
        titleKk,
        titleEn,
        descriptionRu,
        descriptionKk,
        descriptionEn,
        value,
        addressRu,
        addressEn,
        addressKk,
        latitude,
        longitude,
        isActive,
        hasCover,
        phone,
        additionalPhone,
        email,
        whatsapp,
        telegram,
        instagram,
        tiktok,
        createdAt,
        updatedAt,
        deletedAt,
        image,
        city,
      ];
}

class FieldListEntity {
  static List<FieldEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FieldEntity.fromJson(json)).toList();
  }
}
