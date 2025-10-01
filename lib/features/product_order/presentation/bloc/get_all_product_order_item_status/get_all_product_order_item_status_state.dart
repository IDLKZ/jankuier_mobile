import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_status_entity.dart';

abstract class GetAllProductOrderItemStatusState extends Equatable {
  const GetAllProductOrderItemStatusState();

  @override
  List<Object?> get props => [];
}

class GetAllProductOrderItemStatusInitial
    extends GetAllProductOrderItemStatusState {
  const GetAllProductOrderItemStatusInitial();
}

class GetAllProductOrderItemStatusLoading
    extends GetAllProductOrderItemStatusState {
  const GetAllProductOrderItemStatusLoading();
}

class GetAllProductOrderItemStatusLoaded
    extends GetAllProductOrderItemStatusState {
  final List<ProductOrderItemStatusEntity> statuses;

  const GetAllProductOrderItemStatusLoaded(this.statuses);

  @override
  List<Object?> get props => [statuses];
}

class GetAllProductOrderItemStatusError
    extends GetAllProductOrderItemStatusState {
  final String message;

  const GetAllProductOrderItemStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
