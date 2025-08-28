import 'package:equatable/equatable.dart';

import '../../../../../core/common/entities/file_entity.dart';

class ProductCategoryEntity extends Equatable {
  final int id;
  final int? imageId;
  final String titleRu;
  final String? titleKk;
  final String? titleEn;
  final String? descriptionRu;
  final String? descriptionKk;
  final String? descriptionEn;
  final String value;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final FileEntity? image;

  const ProductCategoryEntity({
    required this.id,
    this.imageId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    required this.value,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.image,
  });

  factory ProductCategoryEntity.fromJson(Map<String, dynamic> json) {
    return ProductCategoryEntity(
      id: json['id'],
      imageId: json['image_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      value: json['value'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_id': imageId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'description_ru': descriptionRu,
      'description_kk': descriptionKk,
      'description_en': descriptionEn,
      'value': value,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'image': image?.toJson(),
    };
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
        value,
        isActive,
        createdAt,
        updatedAt,
        deletedAt,
        image,
      ];
}

class ProductCategoryListEntity {
  static List<ProductCategoryEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductCategoryEntity.fromJson(json))
        .toList();
  }
}
