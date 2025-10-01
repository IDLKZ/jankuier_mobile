import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';

import '../../../ticket/data/entities/ticket_order/payment_transaction_entity.dart';
import 'alatau_create_response_order_entity.dart';

// Entity для ответа заказа продуктов
class ProductOrderResponseEntity extends Equatable {
  final ProductOrderEntity? productOrder;
  final List<ProductOrderItemEntity>? productOrderItems;
  final AlatauCreateResponseOrderEntity? order;
  final PaymentTransactionEntity? paymentTransaction;
  final bool isSuccess;
  final String message;

  const ProductOrderResponseEntity({
    this.productOrder,
    this.productOrderItems,
    this.order,
    this.paymentTransaction,
    required this.isSuccess,
    required this.message,
  });

  factory ProductOrderResponseEntity.fromJson(Map<String, dynamic> json) {
    return ProductOrderResponseEntity(
      productOrder: json['product_order'] != null
          ? ProductOrderEntity.fromJson(json['product_order'])
          : null,
      productOrderItems: json['product_order_items'] != null
          ? (json['product_order_items'] as List<dynamic>)
              .map((item) => ProductOrderItemEntity.fromJson(item))
              .toList()
          : null,
      order: json['order'] != null
          ? AlatauCreateResponseOrderEntity.fromJson(json['order'])
          : null,
      paymentTransaction: json['payment_transaction'] != null
          ? PaymentTransactionEntity.fromJson(json['payment_transaction'])
          : null,
      isSuccess: json['is_success'] ?? false,
      message: json['message'] ?? 'OK',
    );
  }

  @override
  List<Object?> get props => [
        productOrder,
        productOrderItems,
        order,
        paymentTransaction,
        isSuccess,
        message,
      ];
}
