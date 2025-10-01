import 'package:equatable/equatable.dart';

abstract class CancelOrderItemEvent extends Equatable {
  const CancelOrderItemEvent();

  @override
  List<Object?> get props => [];
}

class CancelItemRequested extends CancelOrderItemEvent {
  final int productOrderItemId;

  const CancelItemRequested(this.productOrderItemId);

  @override
  List<Object?> get props => [productOrderItemId];
}
