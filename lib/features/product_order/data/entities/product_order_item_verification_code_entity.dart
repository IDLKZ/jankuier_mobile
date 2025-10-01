import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';

import '../../../auth/data/entities/user_entity.dart';

// Entity для кода верификации элемента заказа (из ProductOrderItemVerificationCodeWithRelationsRDTO)
class ProductOrderItemVerificationCodeEntity extends Equatable {
  final int id;
  final int orderItemId;
  final int? responsibleUserId;
  final String code;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProductOrderItemEntity? orderItem;
  final UserEntity? responsibleUser;

  const ProductOrderItemVerificationCodeEntity({
    required this.id,
    required this.orderItemId,
    this.responsibleUserId,
    required this.code,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.orderItem,
    this.responsibleUser,
  });

  factory ProductOrderItemVerificationCodeEntity.fromJson(
      Map<String, dynamic> json) {
    return ProductOrderItemVerificationCodeEntity(
      id: json['id'] ?? 0,
      orderItemId: json['order_item_id'] ?? 0,
      responsibleUserId: json['responsible_user_id'],
      code: json['code'] ?? '',
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      orderItem: json['order_item'] != null
          ? ProductOrderItemEntity.fromJson(json['order_item'])
          : null,
      responsibleUser: json['responsible_user'] != null
          ? UserEntity.fromJson(json['responsible_user'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderItemId,
        responsibleUserId,
        code,
        isActive,
        createdAt,
        updatedAt,
        orderItem,
        responsibleUser,
      ];
}

// Parameter для создания кода верификации
class ProductOrderItemVerificationCodeCreateParameter {
  final int orderItemId;
  final int? responsibleUserId;
  final String code;
  final bool isActive;

  const ProductOrderItemVerificationCodeCreateParameter({
    required this.orderItemId,
    this.responsibleUserId,
    required this.code,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_item_id': orderItemId,
      if (responsibleUserId != null) 'responsible_user_id': responsibleUserId,
      'code': code,
      'is_active': isActive,
    };
  }

  ProductOrderItemVerificationCodeCreateParameter copyWith({
    int? orderItemId,
    int? responsibleUserId,
    String? code,
    bool? isActive,
  }) {
    return ProductOrderItemVerificationCodeCreateParameter(
      orderItemId: orderItemId ?? this.orderItemId,
      responsibleUserId: responsibleUserId ?? this.responsibleUserId,
      code: code ?? this.code,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Список Entity
class ProductOrderItemVerificationCodeListEntity {
  static List<ProductOrderItemVerificationCodeEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductOrderItemVerificationCodeEntity.fromJson(json))
        .toList();
  }
}
