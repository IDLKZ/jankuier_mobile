import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_description_mixin.dart';
import 'package:jankuier_mobile/core/mixins/localized_price_per_mixin.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';
import '../../../../../core/common/entities/file_entity.dart';
import 'academy_entity.dart';

class AcademyGroupEntity extends Equatable
    with LocalizedDescriptionEntity, LocalizedPricePerEntity {
  final int id;
  final int academyId;
  final int? imageId;

  final String name;
  @override
  final String? descriptionRu;
  @override
  final String? descriptionKk;
  @override
  final String? descriptionEn;

  final String value;

  final int minAge;
  final int maxAge;

  final bool isActive;
  final bool isRecruiting;
  final int gender; // 0 - оба, 1 - мужской, 2 - женский

  final int bookedSpace;
  final int freeSpace;

  final double? price;
  @override
  final String? pricePerRu;
  @override
  final String? pricePerKk;
  @override
  final String? pricePerEn;

  final int? averageTrainingTimeInMinute;

  final DateTime createdAt;
  final DateTime updatedAt;

  final AcademyEntity? academy;
  final FileEntity? image;

  const AcademyGroupEntity({
    required this.id,
    required this.academyId,
    this.imageId,
    required this.name,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    required this.value,
    required this.minAge,
    required this.maxAge,
    this.isActive = true,
    this.isRecruiting = false,
    required this.gender,
    this.bookedSpace = 0,
    this.freeSpace = 0,
    this.price,
    this.pricePerRu,
    this.pricePerKk,
    this.pricePerEn,
    this.averageTrainingTimeInMinute,
    required this.createdAt,
    required this.updatedAt,
    this.academy,
    this.image,
  });

  factory AcademyGroupEntity.fromJson(Map<String, dynamic> json) {
    return AcademyGroupEntity(
      id: json['id'],
      academyId: json['academy_id'],
      imageId: json['image_id'],
      name: json['name'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      value: json['value'],
      minAge: json['min_age'],
      maxAge: json['max_age'],
      isActive: json['is_active'] ?? true,
      isRecruiting: json['is_recruiting'] ?? false,
      gender: json['gender'],
      bookedSpace: json['booked_space'] ?? 0,
      freeSpace: json['free_space'] ?? 0,
      price:
          json['price'] != null ? double.parse(json['price'].toString()) : null,
      pricePerRu: json['price_per_ru'],
      pricePerKk: json['price_per_kk'],
      pricePerEn: json['price_per_en'],
      averageTrainingTimeInMinute: json['average_training_time_in_minute'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      academy: json['academy'] != null
          ? AcademyEntity.fromJson(json['academy'])
          : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'academy_id': academyId,
      'image_id': imageId,
      'name': name,
      'description_ru': descriptionRu,
      'description_kk': descriptionKk,
      'description_en': descriptionEn,
      'value': value,
      'min_age': minAge,
      'max_age': maxAge,
      'is_active': isActive,
      'is_recruiting': isRecruiting,
      'gender': gender,
      'booked_space': bookedSpace,
      'free_space': freeSpace,
      'price': price,
      'price_per_ru': pricePerRu,
      'price_per_kk': pricePerKk,
      'price_per_en': pricePerEn,
      'average_training_time_in_minute': averageTrainingTimeInMinute,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'academy': academy?.toJson(),
      'image': image?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        academyId,
        imageId,
        name,
        descriptionRu,
        descriptionKk,
        descriptionEn,
        value,
        minAge,
        maxAge,
        isActive,
        isRecruiting,
        gender,
        bookedSpace,
        freeSpace,
        price,
        pricePerRu,
        pricePerKk,
        pricePerEn,
        averageTrainingTimeInMinute,
        createdAt,
        updatedAt,
        academy,
        image,
      ];
}

class AcademyGroupListEntity {
  static List<AcademyGroupEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AcademyGroupEntity.fromJson(json)).toList();
  }
}
