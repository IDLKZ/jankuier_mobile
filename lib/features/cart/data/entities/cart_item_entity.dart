import 'package:equatable/equatable.dart';

import '../../../services/data/entities/product/product_entity.dart';
import '../../../services/data/entities/product/product_variant_entity.dart';

// Entity для элемента корзины (из CartItemWithRelationsRDTO)
class CartItemEntity extends Equatable {
  final int id;
  final int cartId;
  final int productId;
  final int? variantId;
  final int qty;
  final String? sku;
  final double productPrice;
  final double deltaPrice;
  final double unitPrice;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ProductEntity? product;
  final ProductVariantEntity? variant;

  const CartItemEntity({
    required this.id,
    required this.cartId,
    required this.productId,
    this.variantId,
    required this.qty,
    this.sku,
    required this.productPrice,
    required this.deltaPrice,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.product,
    this.variant,
  });

  factory CartItemEntity.fromJson(Map<String, dynamic> json) {
    return CartItemEntity(
      id: json['id'] ?? 0,
      cartId: json['cart_id'] ?? 0,
      productId: json['product_id'] ?? 0,
      variantId: json['variant_id'],
      qty: json['qty'] ?? 0,
      sku: json['sku'],
      productPrice: (json['product_price'] ?? 0).toDouble(),
      deltaPrice: (json['delta_price'] ?? 0).toDouble(),
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      product: json['product'] != null
          ? ProductEntity.fromJson(json['product'])
          : null,
      variant: json['variant'] != null
          ? ProductVariantEntity.fromJson(json['variant'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        cartId,
        productId,
        variantId,
        qty,
        sku,
        productPrice,
        deltaPrice,
        unitPrice,
        totalPrice,
        createdAt,
        updatedAt,
        deletedAt,
        product,
        variant,
      ];
}

// Parameter для создания элемента корзины
class CartItemCreateParameter {
  final int cartId;
  final int productId;
  final int? variantId;
  final int qty;
  final String? sku;
  final double productPrice;
  final double deltaPrice;

  const CartItemCreateParameter({
    required this.cartId,
    required this.productId,
    this.variantId,
    required this.qty,
    this.sku,
    required this.productPrice,
    required this.deltaPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartId,
      'product_id': productId,
      if (variantId != null) 'variant_id': variantId,
      'qty': qty,
      if (sku != null) 'sku': sku,
      'product_price': productPrice,
      'delta_price': deltaPrice,
    };
  }

  CartItemCreateParameter copyWith({
    int? cartId,
    int? productId,
    int? variantId,
    int? qty,
    String? sku,
    double? productPrice,
    double? deltaPrice,
  }) {
    return CartItemCreateParameter(
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      variantId: variantId ?? this.variantId,
      qty: qty ?? this.qty,
      sku: sku ?? this.sku,
      productPrice: productPrice ?? this.productPrice,
      deltaPrice: deltaPrice ?? this.deltaPrice,
    );
  }
}

// Список Entity
class CartItemListEntity {
  static List<CartItemEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CartItemEntity.fromJson(json)).toList();
  }
}
