import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';

import '../../../../../core/common/entities/city_entity.dart';
import '../../../../../core/common/entities/file_entity.dart';

class ProductVariantEntity extends Equatable {
  final int id;
  final int productId;
  final int? imageId;
  final int? cityId;
  final String titleRu;
  final String? titleKk;
  final String? titleEn;
  final String value;
  final String? sku;
  final double? priceDelta;
  final int stock;
  final bool isActive;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;

  final ProductEntity? product;
  final FileEntity? image;
  final CityEntity? city;

  const ProductVariantEntity({
    required this.id,
    required this.productId,
    this.imageId,
    this.cityId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.value,
    this.sku,
    this.priceDelta,
    required this.stock,
    required this.isActive,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.product,
    this.image,
    this.city,
  });

  factory ProductVariantEntity.fromJson(Map<String, dynamic> json) {
    return ProductVariantEntity(
      id: json['id'],
      productId: json['product_id'],
      imageId: json['image_id'],
      cityId: json['city_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      value: json['value'],
      sku: json['sku'],
      priceDelta: json['price_delta'] != null
          ? double.tryParse(json['price_delta'].toString())
          : null,
      stock: json['stock'],
      isActive: json['is_active'],
      isDefault: json['is_default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      product: json['product'] != null
          ? ProductEntity.fromJson(json['product'])
          : null,
      image: json['image'] != null ? FileEntity.fromJson(json['image']) : null,
      city: json['city'] != null ? CityEntity.fromJson(json['city']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product_id': productId,
      'image_id': imageId,
      'city_id': cityId,
      'title_ru': titleRu,
      'title_kk': titleKk,
      'title_en': titleEn,
      'value': value,
      'sku': sku,
      'price_delta': priceDelta,
      'stock': stock,
      'is_active': isActive,
      'is_default': isDefault,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'product': product?.toJson(),
      'image': image?.toJson(),
      'city': city?.toJson(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        productId,
        imageId,
        cityId,
        titleRu,
        titleKk,
        titleEn,
        value,
        sku,
        priceDelta,
        stock,
        isActive,
        isDefault,
        createdAt,
        updatedAt,
        deletedAt,
        product,
        image,
        city,
      ];
}
