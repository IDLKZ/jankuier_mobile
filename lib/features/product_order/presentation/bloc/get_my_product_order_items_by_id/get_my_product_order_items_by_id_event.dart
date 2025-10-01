import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_item_pagination_parameter.dart';

abstract class GetMyProductOrderItemsByIdEvent extends Equatable {
  const GetMyProductOrderItemsByIdEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyProductOrderItemsById extends GetMyProductOrderItemsByIdEvent {
  final int productOrderId;
  final ProductOrderItemPaginationParameter parameter;

  const LoadMyProductOrderItemsById(this.productOrderId, this.parameter);

  @override
  List<Object?> get props => [productOrderId, parameter];
}
