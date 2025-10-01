import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_status_all_parameter.dart';

abstract class GetAllProductOrderStatusEvent extends Equatable {
  const GetAllProductOrderStatusEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllProductOrderStatus extends GetAllProductOrderStatusEvent {
  final ProductOrderStatusFilterParameter parameter;

  const LoadAllProductOrderStatus(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
