import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_variant_entity.dart';

import '../../../../../core/common/entities/file_entity.dart';

class ProductGalleryEntity extends Equatable {
  final int id;
  final int productId;
  final int? variantId;
  final int? fileId;
  final DateTime createdAt;
  final DateTime updatedAt;

  final ProductEntity? product;
  final ProductVariantEntity? variant;
  final FileEntity? file;

  const ProductGalleryEntity({
    required this.id,
    required this.productId,
    this.variantId,
    this.fileId,
    required this.createdAt,
    required this.updatedAt,
    this.product,
    this.variant,
    this.file,
  });

  factory ProductGalleryEntity.fromJson(Map<String, dynamic> json) {
    return ProductGalleryEntity(
      id: json['id'],
      productId: json['product_id'],
      variantId: json['variant_id'],
      fileId: json['file_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      product: json['product'] != null
          ? ProductEntity.fromJson(json['product'])
          : null,
      variant: json['variant'] != null
          ? ProductVariantEntity.fromJson(json['variant'])
          : null,
      file: json['file'] != null ? FileEntity.fromJson(json['file']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'variant_id': variantId,
      'file_id': fileId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'product': product?.toJson(),
      'variant': variant?.toJson(),
      'file': file?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        variantId,
        fileId,
        createdAt,
        updatedAt,
        product,
        variant,
        file,
      ];
}
