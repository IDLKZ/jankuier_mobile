import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_category_entity.dart';

import '../../../../../core/common/entities/city_entity.dart';
import '../../../../../core/common/entities/file_entity.dart';

class ProductEntity extends Equatable {
  final int id;
  final int? imageId;
  final int? cityId;
  final int? categoryId;
  final String titleRu;
  final String? titleKk;
  final String? titleEn;
  final String? descriptionRu;
  final String? descriptionKk;
  final String? descriptionEn;
  final String value;
  final String sku;
  final double basePrice;
  final double? oldPrice;
  final int gender;
  final bool isForChildren;
  final bool isRecommended;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final FileEntity? image;
  final CityEntity? city;
  final ProductCategoryEntity? category;

  const ProductEntity({
    required this.id,
    this.imageId,
    this.cityId,
    this.categoryId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    required this.value,
    required this.sku,
    required this.basePrice,
    this.oldPrice,
    required this.gender,
    required this.isForChildren,
    required this.isRecommended,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.image,
    this.city,
    this.category,
  });

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(
      id: json['id'],
      imageId: json['image_id'],
      cityId: json['city_id'],
      categoryId: json['category_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      value: json['value'],
      sku: json['sku'],
      basePrice: double.parse(json['base_price'].toString()),
      oldPrice: json['old_price'] != null
          ? double.parse(json['old_price'].toString())
          : null,
      gender: json['gender'],
      isForChildren: json['is_for_children'],
      isRecommended: json['is_recommended'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
      city: json['city'] != null ? CityEntity.fromJson(json['city']) : null,
      category: json['category'] != null
          ? ProductCategoryEntity.fromJson(json['category'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_id': imageId,
      'city_id': cityId,
      'category_id': categoryId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'description_ru': descriptionRu,
      'description_kk': descriptionKk,
      'description_en': descriptionEn,
      'value': value,
      'sku': sku,
      'base_price': basePrice,
      'old_price': oldPrice,
      'gender': gender,
      'is_for_children': isForChildren,
      'is_recommended': isRecommended,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'image': image?.toJson(),
      'city': city?.toJson(),
      'category': category?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        imageId,
        cityId,
        categoryId,
        titleRu,
        titleKk,
        titleEn,
        descriptionRu,
        descriptionKk,
        descriptionEn,
        value,
        sku,
        basePrice,
        oldPrice,
        gender,
        isForChildren,
        isRecommended,
        isActive,
        createdAt,
        updatedAt,
        deletedAt,
        image,
        city,
        category,
      ];
}

class ProductListEntity {
  static List<ProductEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductEntity.fromJson(json)).toList();
  }
}
