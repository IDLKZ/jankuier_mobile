import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';

abstract class CancelOrderItemState extends Equatable {
  const CancelOrderItemState();

  @override
  List<Object?> get props => [];
}

class CancelOrderItemInitial extends CancelOrderItemState {
  const CancelOrderItemInitial();
}

class CancelOrderItemLoading extends CancelOrderItemState {
  const CancelOrderItemLoading();
}

class CancelOrderItemSuccess extends CancelOrderItemState {
  final ProductOrderItemEntity? item;

  const CancelOrderItemSuccess(this.item);

  @override
  List<Object?> get props => [item];
}

class CancelOrderItemError extends CancelOrderItemState {
  final String message;

  const CancelOrderItemError(this.message);

  @override
  List<Object?> get props => [message];
}
