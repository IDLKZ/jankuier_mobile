import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_status_entity.dart';

import '../../../auth/data/entities/user_entity.dart';
import '../../../ticket/data/entities/ticket_order/payment_transaction_entity.dart';

// Entity для заказа продукта (из ProductOrderWithRelationsRDTO)
class ProductOrderEntity extends Equatable {
  final int id;
  final int userId;
  final int? statusId;
  final int? canceledById;
  final int? paymentTransactionId;
  final double shippingTotalPrice;
  final double taxesPrice;
  final double totalPrice;
  final double refundedTotal;
  final bool isActive;
  final bool isCanceled;
  final bool isPaid;
  final bool isRefunded;
  final String? cancelReason;
  final String? cancelRefundReason;
  final String? email;
  final String? phone;
  final DateTime? paidUntil;
  final DateTime? paidAt;
  final String? paidOrder;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final UserEntity? user;
  final UserEntity? canceledBy;
  final ProductOrderStatusEntity? status;
  final PaymentTransactionEntity? paymentTransaction;

  const ProductOrderEntity({
    required this.id,
    required this.userId,
    this.statusId,
    this.canceledById,
    this.paymentTransactionId,
    required this.shippingTotalPrice,
    required this.taxesPrice,
    required this.totalPrice,
    required this.refundedTotal,
    required this.isActive,
    required this.isCanceled,
    required this.isPaid,
    required this.isRefunded,
    this.cancelReason,
    this.cancelRefundReason,
    this.email,
    this.phone,
    this.paidUntil,
    this.paidAt,
    this.paidOrder,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.user,
    this.canceledBy,
    this.status,
    this.paymentTransaction,
  });

  factory ProductOrderEntity.fromJson(Map<String, dynamic> json) {
    return ProductOrderEntity(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      statusId: json['status_id'],
      canceledById: json['canceled_by_id'],
      paymentTransactionId: json['payment_transaction_id'],
      shippingTotalPrice: _parseDouble(json['shipping_total_price']),
      taxesPrice: _parseDouble(json['taxes_price']),
      totalPrice: _parseDouble(json['total_price']),
      refundedTotal: _parseDouble(json['refunded_total']),
      isActive: json['is_active'] ?? true,
      isCanceled: json['is_canceled'] ?? false,
      isPaid: json['is_paid'] ?? false,
      isRefunded: json['is_refunded'] ?? false,
      cancelReason: json['cancel_reason'],
      cancelRefundReason: json['cancel_refund_reason'],
      email: json['email'],
      phone: json['phone'],
      paidUntil: json['paid_until'] != null
          ? DateTime.tryParse(json['paid_until'])
          : null,
      paidAt:
          json['paid_at'] != null ? DateTime.tryParse(json['paid_at']) : null,
      paidOrder: json['paid_order'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      canceledBy: json['canceled_by'] != null
          ? UserEntity.fromJson(json['canceled_by'])
          : null,
      status: json['status'] != null
          ? ProductOrderStatusEntity.fromJson(json['status'])
          : null,
      paymentTransaction: json['payment_transaction'] != null
          ? PaymentTransactionEntity.fromJson(json['payment_transaction'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        statusId,
        canceledById,
        paymentTransactionId,
        shippingTotalPrice,
        taxesPrice,
        totalPrice,
        refundedTotal,
        isActive,
        isCanceled,
        isPaid,
        isRefunded,
        cancelReason,
        cancelRefundReason,
        email,
        phone,
        paidUntil,
        paidAt,
        paidOrder,
        createdAt,
        updatedAt,
        deletedAt,
        user,
        canceledBy,
        status,
        paymentTransaction,
      ];

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }
}

// Список Entity
class ProductOrderListEntity {
  static List<ProductOrderEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ProductOrderEntity.fromJson(json)).toList();
  }
}
