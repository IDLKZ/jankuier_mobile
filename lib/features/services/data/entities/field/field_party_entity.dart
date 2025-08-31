import 'package:equatable/equatable.dart';
import '../../../../../core/common/entities/file_entity.dart';
import 'field_entity.dart';
import 'field_party_schedule_settings_entity.dart';

class FieldPartyEntity extends Equatable {
  final int id;
  final int? imageId;
  final int fieldId;

  final String titleRu;
  final String? titleKk;
  final String? titleEn;

  final String value;

  final int personQty;
  final int lengthM;
  final int widthM;
  final int? deepthM;

  final String? latitude;
  final String? longitude;

  final bool isActive;
  final bool isCovered;
  final bool isDefault;

  final int coverType;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final FileEntity? image;
  final FieldEntity? field;
  final FieldPartyScheduleSettingsEntity? activeScheduleSetting;

  const FieldPartyEntity({
    required this.id,
    this.imageId,
    required this.fieldId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.value,
    required this.personQty,
    required this.lengthM,
    required this.widthM,
    this.deepthM,
    this.latitude,
    this.longitude,
    this.isActive = true,
    this.isCovered = false,
    this.isDefault = false,
    required this.coverType,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.image,
    this.field,
    this.activeScheduleSetting,
  });

  factory FieldPartyEntity.fromJson(Map<String, dynamic> json) {
    return FieldPartyEntity(
      id: json['id'],
      imageId: json['image_id'],
      fieldId: json['field_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      value: json['value'],
      personQty: json['person_qty'],
      lengthM: json['length_m'],
      widthM: json['width_m'],
      deepthM: json['deepth_m'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      isActive: json['is_active'] ?? true,
      isCovered: json['is_covered'] ?? false,
      isDefault: json['is_default'] ?? false,
      coverType: json['cover_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
      field: json['field'] != null ? FieldEntity.fromJson(json['field']) : null,
      activeScheduleSetting: json['active_schedule_setting'] != null
          ? FieldPartyScheduleSettingsEntity.fromJson(
              json['active_schedule_setting'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_id': imageId,
      'field_id': fieldId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'value': value,
      'person_qty': personQty,
      'length_m': lengthM,
      'width_m': widthM,
      'deepth_m': deepthM,
      'latitude': latitude,
      'longitude': longitude,
      'is_active': isActive,
      'is_covered': isCovered,
      'is_default': isDefault,
      'cover_type': coverType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'image': image?.toJson(),
      'field': field?.toJson(),
      'active_schedule_setting': activeScheduleSetting?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        imageId,
        fieldId,
        titleRu,
        titleKk,
        titleEn,
        value,
        personQty,
        lengthM,
        widthM,
        deepthM,
        latitude,
        longitude,
        isActive,
        isCovered,
        isDefault,
        coverType,
        createdAt,
        updatedAt,
        deletedAt,
        image,
        field,
        activeScheduleSetting,
      ];
}

class FieldPartyListEntity {
  static List<FieldPartyEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => FieldPartyEntity.fromJson(json)).toList();
  }
}
