import 'package:equatable/equatable.dart';

import '../../../auth/data/entities/user_entity.dart';

// Entity для корзины (из CartWithRelationsRDTO)
class CartEntity extends Equatable {
  final int id;
  final int userId;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final UserEntity? user;

  const CartEntity({
    required this.id,
    required this.userId,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.user,
  });

  factory CartEntity.fromJson(Map<String, dynamic> json) {
    return CartEntity(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        totalPrice,
        createdAt,
        updatedAt,
        deletedAt,
        user,
      ];
}

// Parameter для создания корзины
class CartCreateParameter {
  final int userId;
  final double totalPrice;
  final Map<String, dynamic>? cartItems;

  const CartCreateParameter({
    required this.userId,
    required this.totalPrice,
    this.cartItems,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'total_price': totalPrice,
      if (cartItems != null) 'cart_items': cartItems,
    };
  }

  CartCreateParameter copyWith({
    int? userId,
    double? totalPrice,
    Map<String, dynamic>? cartItems,
  }) {
    return CartCreateParameter(
      userId: userId ?? this.userId,
      totalPrice: totalPrice ?? this.totalPrice,
      cartItems: cartItems ?? this.cartItems,
    );
  }
}

// Список Entity
class CartListEntity {
  static List<CartEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => CartEntity.fromJson(json)).toList();
  }
}
