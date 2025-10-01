import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';

// Entity для полного заказа продукта
class FullProductOrderEntity extends Equatable {
  final ProductOrderEntity? productOrder;
  final List<ProductOrderItemEntity>? productOrderItems;

  const FullProductOrderEntity({
    this.productOrder,
    this.productOrderItems,
  });

  factory FullProductOrderEntity.fromJson(Map<String, dynamic> json) {
    return FullProductOrderEntity(
      productOrder: json['product_order'] != null
          ? ProductOrderEntity.fromJson(json['product_order'])
          : null,
      productOrderItems: json['product_order_items'] != null
          ? (json['product_order_items'] as List<dynamic>)
              .map((item) => ProductOrderItemEntity.fromJson(item))
              .toList()
          : null,
    );
  }

  @override
  List<Object?> get props => [productOrder, productOrderItems];
}
