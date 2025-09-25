import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_description_mixin.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';

import 'modification_type_entity.dart';

class ModificationValueEntity extends Equatable
    with LocalizedTitleEntity, LocalizedDescriptionEntity {
  final int id;
  final int modificationTypeId;
  final int productId;
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
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final ModificationTypeEntity? modificationType;
  final ProductEntity? product;

  const ModificationValueEntity({
    required this.id,
    required this.modificationTypeId,
    required this.productId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    this.descriptionRu,
    this.descriptionKk,
    this.descriptionEn,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.modificationType,
    this.product,
  });

  factory ModificationValueEntity.fromJson(Map<String, dynamic> json) {
    return ModificationValueEntity(
      id: json['id'],
      modificationTypeId: json['modification_type_id'],
      productId: json['product_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      descriptionRu: json['description_ru'],
      descriptionKk: json['description_kk'],
      descriptionEn: json['description_en'],
      isActive: json['is_active'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      modificationType: json['modification_type'] != null
          ? ModificationTypeEntity.fromJson(json['modification_type'])
          : null,
      product: json['product'] != null
          ? ProductEntity.fromJson(json['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'modification_type_id': modificationTypeId,
      'product_id': productId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'description_ru': descriptionRu,
      'description_kk': descriptionKk,
      'description_en': descriptionEn,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'modification_type': modificationType?.toJson(),
      'product': product?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        modificationTypeId,
        productId,
        titleRu,
        titleKk,
        titleEn,
        descriptionRu,
        descriptionKk,
        descriptionEn,
        isActive,
        createdAt,
        updatedAt,
        deletedAt,
        modificationType,
        product,
      ];
}
