import 'package:equatable/equatable.dart';

abstract class ClearCartEvent extends Equatable {
  const ClearCartEvent();

  @override
  List<Object?> get props => [];
}

class ClearCartRequested extends ClearCartEvent {
  final int cartId;

  const ClearCartRequested(this.cartId);

  @override
  List<Object?> get props => [cartId];
}
