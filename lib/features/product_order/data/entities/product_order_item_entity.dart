import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_history_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_status_entity.dart';

import '../../../../core/common/entities/city_entity.dart';
import '../../../auth/data/entities/user_entity.dart';
import '../../../services/data/entities/product/product_entity.dart';
import '../../../services/data/entities/product/product_variant_entity.dart';

// Entity для элемента заказа продукта (из ProductOrderItemWithRelationsRDTO)
class ProductOrderItemEntity extends Equatable {
  final int id;
  final int orderId;
  final int? statusId;
  final int? canceledById;
  final int productId;
  final int? variantId;
  final int? fromCityId;
  final int? toCityId;
  final int qty;
  final String? sku;
  final double productPrice;
  final double deltaPrice;
  final double shippingPrice;
  final double unitPrice;
  final double totalPrice;
  final double refundedTotal;
  final bool isActive;
  final bool isCanceled;
  final bool isPaid;
  final bool isRefunded;
  final String? cancelReason;
  final String? cancelRefundReason;
  final DateTime? deliveryDate;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ProductOrderEntity? order;
  final ProductOrderItemStatusEntity? status;
  final UserEntity? canceledBy;
  final ProductEntity? product;
  final ProductVariantEntity? variant;
  final CityEntity? fromCity;
  final CityEntity? toCity;
  final List<ProductOrderItemHistoryEntity>? historyRecords;

  const ProductOrderItemEntity({
    required this.id,
    required this.orderId,
    this.statusId,
    this.canceledById,
    required this.productId,
    this.variantId,
    this.fromCityId,
    this.toCityId,
    required this.qty,
    this.sku,
    required this.productPrice,
    required this.deltaPrice,
    required this.shippingPrice,
    required this.unitPrice,
    required this.totalPrice,
    required this.refundedTotal,
    required this.isActive,
    required this.isCanceled,
    required this.isPaid,
    required this.isRefunded,
    this.cancelReason,
    this.cancelRefundReason,
    this.deliveryDate,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.order,
    this.status,
    this.canceledBy,
    this.product,
    this.variant,
    this.fromCity,
    this.toCity,
    this.historyRecords,
  });

  factory ProductOrderItemEntity.fromJson(Map<String, dynamic> json) {
    return ProductOrderItemEntity(
      id: json['id'] ?? 0,
      orderId: json['order_id'] ?? 0,
      statusId: json['status_id'],
      canceledById: json['canceled_by_id'],
      productId: json['product_id'] ?? 0,
      variantId: json['variant_id'],
      fromCityId: json['from_city_id'],
      toCityId: json['to_city_id'],
      qty: json['qty'] ?? 0,
      sku: json['sku'],
      productPrice: (json['product_price'] ?? 0).toDouble(),
      deltaPrice: (json['delta_price'] ?? 0).toDouble(),
      shippingPrice: (json['shipping_price'] ?? 0).toDouble(),
      unitPrice: (json['unit_price'] ?? 0).toDouble(),
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      refundedTotal: (json['refunded_total'] ?? 0).toDouble(),
      isActive: json['is_active'] ?? true,
      isCanceled: json['is_canceled'] ?? false,
      isPaid: json['is_paid'] ?? false,
      isRefunded: json['is_refunded'] ?? false,
      cancelReason: json['cancel_reason'],
      cancelRefundReason: json['cancel_refund_reason'],
      deliveryDate: json['delivery_date'] != null
          ? DateTime.tryParse(json['delivery_date'])
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      order: json['order'] != null
          ? ProductOrderEntity.fromJson(json['order'])
          : null,
      status: json['status'] != null
          ? ProductOrderItemStatusEntity.fromJson(json['status'])
          : null,
      canceledBy: json['canceled_by'] != null
          ? UserEntity.fromJson(json['canceled_by'])
          : null,
      product: json['product'] != null
          ? ProductEntity.fromJson(json['product'])
          : null,
      variant: json['variant'] != null
          ? ProductVariantEntity.fromJson(json['variant'])
          : null,
      fromCity: json['from_city'] != null
          ? CityEntity.fromJson(json['from_city'])
          : null,
      toCity:
          json['to_city'] != null ? CityEntity.fromJson(json['to_city']) : null,
      historyRecords: json['history_records'] != null
          ? (json['history_records'] as List<dynamic>)
              .map((item) => ProductOrderItemHistoryEntity.fromJson(item))
              .toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderId,
        statusId,
        canceledById,
        productId,
        variantId,
        fromCityId,
        toCityId,
        qty,
        sku,
        productPrice,
        deltaPrice,
        shippingPrice,
        unitPrice,
        totalPrice,
        refundedTotal,
        isActive,
        isCanceled,
        isPaid,
        isRefunded,
        cancelReason,
        cancelRefundReason,
        deliveryDate,
        createdAt,
        updatedAt,
        deletedAt,
        order,
        status,
        canceledBy,
        product,
        variant,
        fromCity,
        toCity,
        historyRecords,
      ];
}

// Список Entity
class ProductOrderItemListEntity {
  static List<ProductOrderItemEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductOrderItemEntity.fromJson(json))
        .toList();
  }
}
