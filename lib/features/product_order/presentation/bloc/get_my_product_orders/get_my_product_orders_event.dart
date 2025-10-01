import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_pagination_parameter.dart';

abstract class GetMyProductOrdersEvent extends Equatable {
  const GetMyProductOrdersEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyProductOrders extends GetMyProductOrdersEvent {
  final ProductOrderPaginationParameter parameter;

  const LoadMyProductOrders(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
