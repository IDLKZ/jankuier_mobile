import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_gallery_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_variant_entity.dart';

import 'modification_value_entity.dart';

class FullProductEntity extends Equatable {
  final ProductEntity product;
  final List<ProductGalleryEntity> galleries;
  final List<ProductVariantEntity> variants;
  final List<ModificationValueEntity> modificationValues;

  const FullProductEntity({
    required this.product,
    required this.galleries,
    required this.variants,
    required this.modificationValues,
  });

  factory FullProductEntity.fromJson(Map<String, dynamic> json) {
    return FullProductEntity(
      product: ProductEntity.fromJson(json['product']),
      galleries: (json['galleries'] as List<dynamic>)
          .map((e) => ProductGalleryEntity.fromJson(e))
          .toList(),
      variants: (json['variants'] as List<dynamic>)
          .map((e) => ProductVariantEntity.fromJson(e))
          .toList(),
      modificationValues: (json['modification_values'] as List<dynamic>)
          .map((e) => ModificationValueEntity.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'galleries': galleries.map((e) => e.toJson()).toList(),
      'variants': variants.map((e) => e.toJson()).toList(),
      'modification_values': modificationValues.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        product,
        galleries,
        variants,
        modificationValues,
      ];
}
