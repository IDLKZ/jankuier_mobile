import 'package:equatable/equatable.dart';

abstract class CancelOrDeleteProductOrderEvent extends Equatable {
  const CancelOrDeleteProductOrderEvent();

  @override
  List<Object?> get props => [];
}

class CancelOrDeleteOrder extends CancelOrDeleteProductOrderEvent {
  final int productOrderId;
  final bool? isDelete;

  const CancelOrDeleteOrder(this.productOrderId, {this.isDelete});

  @override
  List<Object?> get props => [productOrderId, isDelete];
}
