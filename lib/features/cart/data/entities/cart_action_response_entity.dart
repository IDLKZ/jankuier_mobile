import 'package:equatable/equatable.dart';

import 'cart_entity.dart';
import 'cart_item_entity.dart';

// Entity для ответа действий в корзине
class CartActionResponseEntity extends Equatable {
  final CartEntity? cart;
  final List<CartItemEntity>? cartItems;
  final double totalPrice;

  const CartActionResponseEntity({
    this.cart,
    this.cartItems,
    required this.totalPrice,
  });

  factory CartActionResponseEntity.fromJson(Map<String, dynamic> json) {
    return CartActionResponseEntity(
      cart: json['cart'] != null ? CartEntity.fromJson(json['cart']) : null,
      cartItems: json['cart_items'] != null
          ? (json['cart_items'] as List<dynamic>)
              .map((item) => CartItemEntity.fromJson(item))
              .toList()
          : null,
      totalPrice: (json['total_price'] ?? 0.0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [cart, cartItems, totalPrice];
}
