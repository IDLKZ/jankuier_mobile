import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_address_mixin.dart';
import 'package:jankuier_mobile/core/mixins/localized_description_mixin.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';
import '../../../../../core/common/entities/city_entity.dart';
import '../../../../../core/common/entities/file_entity.dart';

class WorkingTimeEntity extends Equatable {
  final int day;
  final String start;
  final String end;

  const WorkingTimeEntity({
    required this.day,
    required this.start,
    required this.end,
  });

  factory WorkingTimeEntity.fromJson(Map<String, dynamic> json) {
    return WorkingTimeEntity(
      day: json['day'],
      start: json['start'],
      end: json['end'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'start': start,
      'end': end,
    };
  }

  @override
  List<Object?> get props => [day, start, end];
}

class AcademyEntity extends Equatable
    with
        LocalizedTitleEntity,
        LocalizedDescriptionEntity,
        LocalizedAddressEntity {
  final int id;
  final int? imageId;
  final int? cityId;
  @override
  final String titleRu;
  @override
  final String? titleKk;
  @override
  final String? titleEn;
  @override
  final String? descriptionRu;
  @override
  final String? descriptionKk;
  @override
  final String? descriptionEn;

  final String value;
  @override
  final String? addressRu;
  @override
  final String? addressKk;
  @override
  final String? addressEn;

  final List<WorkingTimeEntity> workingTime;

  final bool isActive;
  final int gender; // 0 - оба, 1 - мужской, 2 - женский

  final int minAge;
  final int maxAge;

  final double? averagePrice;
  final int? averageTrainingTimeInMinute;

  final String? phone;
  final String? additionalPhone;
  final String? email;
  final String? whatsapp;
  final String? telegram;
  final String? instagram;
  final String? tikTok;
  final String? site;

  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final FileEntity? image;
  final CityEntity? city;

  const AcademyEntity({
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
    this.addressKk,
    this.addressEn,
    this.workingTime = const [],
    this.isActive = true,
    required this.gender,
    required this.minAge,
    required this.maxAge,
    this.averagePrice,
    this.averageTrainingTimeInMinute,
    this.phone,
    this.additionalPhone,
    this.email,
    this.whatsapp,
    this.telegram,
    this.instagram,
    this.tikTok,
    this.site,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.image,
    this.city,
  });

  factory AcademyEntity.fromJson(Map<String, dynamic> json) {
    return AcademyEntity(
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
      addressKk: json['address_kk'],
      addressEn: json['address_en'],
      workingTime: (json['working_time'] as List<dynamic>? ?? [])
          .map((e) => WorkingTimeEntity.fromJson(e))
          .toList(),
      isActive: json['is_active'] ?? true,
      gender: json['gender'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
      averagePrice: json['average_price'] != null
          ? double.parse(json['average_price'].toString())
          : null,
      averageTrainingTimeInMinute: json['average_training_time_in_minute'],
      phone: json['phone'],
      additionalPhone: json['additional_phone'],
      email: json['email'],
      whatsapp: json['whatsapp'],
      telegram: json['telegram'],
      instagram: json['instagram'],
      tikTok: json['tik_tok'],
      site: json['site'],
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
      'address_kk': addressKk,
      'address_en': addressEn,
      'working_time': workingTime.map((e) => e.toJson()).toList(),
      'is_active': isActive,
      'gender': gender,
      'min_age': minAge,
      'max_age': maxAge,
      'average_price': averagePrice,
      'average_training_time_in_minute': averageTrainingTimeInMinute,
      'phone': phone,
      'additional_phone': additionalPhone,
      'email': email,
      'whatsapp': whatsapp,
      'telegram': telegram,
      'instagram': instagram,
      'tik_tok': tikTok,
      'site': site,
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
        addressKk,
        addressEn,
        workingTime,
        isActive,
        gender,
        minAge,
        maxAge,
        averagePrice,
        averageTrainingTimeInMinute,
        phone,
        additionalPhone,
        email,
        whatsapp,
        telegram,
        instagram,
        tikTok,
        site,
        createdAt,
        updatedAt,
        deletedAt,
        image,
        city,
      ];
}

class AcademyListEntity {
  static List<AcademyEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AcademyEntity.fromJson(json)).toList();
  }
}
