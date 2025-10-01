import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';

import '../../../ticket/data/entities/ticket_order/payment_transaction_entity.dart';

// Entity для связи заказа и платежной транзакции (из ProductOrderAndPaymentTransactionWithRelationsRDTO)
class ProductOrderAndPaymentTransactionEntity extends Equatable {
  final int id;
  final int productOrderId;
  final int paymentTransactionId;
  final bool isActive;
  final bool isPrimary;
  final String linkType;
  final String? linkReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ProductOrderEntity? productOrder;
  final PaymentTransactionEntity? paymentTransaction;

  const ProductOrderAndPaymentTransactionEntity({
    required this.id,
    required this.productOrderId,
    required this.paymentTransactionId,
    required this.isActive,
    required this.isPrimary,
    required this.linkType,
    this.linkReason,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.productOrder,
    this.paymentTransaction,
  });

  factory ProductOrderAndPaymentTransactionEntity.fromJson(
      Map<String, dynamic> json) {
    return ProductOrderAndPaymentTransactionEntity(
      id: json['id'] ?? 0,
      productOrderId: json['product_order_id'] ?? 0,
      paymentTransactionId: json['payment_transaction_id'] ?? 0,
      isActive: json['is_active'] ?? true,
      isPrimary: json['is_primary'] ?? false,
      linkType: json['link_type'] ?? '',
      linkReason: json['link_reason'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      productOrder: json['product_order'] != null
          ? ProductOrderEntity.fromJson(json['product_order'])
          : null,
      paymentTransaction: json['payment_transaction'] != null
          ? PaymentTransactionEntity.fromJson(json['payment_transaction'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        productOrderId,
        paymentTransactionId,
        isActive,
        isPrimary,
        linkType,
        linkReason,
        createdAt,
        updatedAt,
        deletedAt,
        productOrder,
        paymentTransaction,
      ];
}

// Parameter для создания связи
class ProductOrderAndPaymentTransactionCreateParameter {
  final int productOrderId;
  final int paymentTransactionId;
  final bool isActive;
  final bool isPrimary;
  final String linkType;
  final String? linkReason;

  const ProductOrderAndPaymentTransactionCreateParameter({
    required this.productOrderId,
    required this.paymentTransactionId,
    this.isActive = true,
    this.isPrimary = false,
    required this.linkType,
    this.linkReason,
  });

  Map<String, dynamic> toJson() {
    return {
      'product_order_id': productOrderId,
      'payment_transaction_id': paymentTransactionId,
      'is_active': isActive,
      'is_primary': isPrimary,
      'link_type': linkType,
      if (linkReason != null) 'link_reason': linkReason,
    };
  }

  ProductOrderAndPaymentTransactionCreateParameter copyWith({
    int? productOrderId,
    int? paymentTransactionId,
    bool? isActive,
    bool? isPrimary,
    String? linkType,
    String? linkReason,
  }) {
    return ProductOrderAndPaymentTransactionCreateParameter(
      productOrderId: productOrderId ?? this.productOrderId,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
      isActive: isActive ?? this.isActive,
      isPrimary: isPrimary ?? this.isPrimary,
      linkType: linkType ?? this.linkType,
      linkReason: linkReason ?? this.linkReason,
    );
  }
}

// Список Entity
class ProductOrderAndPaymentTransactionListEntity {
  static List<ProductOrderAndPaymentTransactionEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductOrderAndPaymentTransactionEntity.fromJson(json))
        .toList();
  }
}
