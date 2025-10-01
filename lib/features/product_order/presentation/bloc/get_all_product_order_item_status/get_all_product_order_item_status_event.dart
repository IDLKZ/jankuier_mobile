import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_item_status_all_parameter.dart';

abstract class GetAllProductOrderItemStatusEvent extends Equatable {
  const GetAllProductOrderItemStatusEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProductOrderItemStatus extends GetAllProductOrderItemStatusEvent {
  final ProductOrderItemStatusFilterParameter parameter;

  const LoadAllProductOrderItemStatus(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
