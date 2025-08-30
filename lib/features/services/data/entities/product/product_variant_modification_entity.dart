import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/modification_value_entity.dart';
import 'product_variant_entity.dart';

class ProductVariantModificationEntity extends Equatable {
  final int id;
  final int variantId;
  final int modificationValueId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  // Дополнительные связи (опционально, если бекенд отдаёт)
  final ProductVariantEntity? variant;
  final ModificationValueEntity? modificationValue;

  const ProductVariantModificationEntity({
    required this.id,
    required this.variantId,
    required this.modificationValueId,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.modificationValue,
    required this.variant,
  });

  factory ProductVariantModificationEntity.fromJson(Map<String, dynamic> json) {
    return ProductVariantModificationEntity(
      id: json['id'],
      variantId: json['variant_id'],
      modificationValueId: json['modification_value_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      variant: json['variant'] != null
          ? ProductVariantEntity.fromJson(json['variant'])
          : null,
      modificationValue: json['modification_value'] != null
          ? ModificationValueEntity.fromJson(json['modification_value'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'variant_id': variantId,
      'modification_value_id': modificationValueId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'variant': variant?.toJson(),
      'modification_value': modificationValue?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        variantId,
        modificationValueId,
        createdAt,
        updatedAt,
        deletedAt,
        variant,
        modificationValue,
      ];
}
