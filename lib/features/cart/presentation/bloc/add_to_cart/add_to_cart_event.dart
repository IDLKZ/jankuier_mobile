import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/add_to_cart_parameter.dart';

abstract class AddToCartEvent extends Equatable {
  const AddToCartEvent();

  @override
  List<Object?> get props => [];
}

class AddToCartRequested extends AddToCartEvent {
  final AddToCartParameter parameter;

  const AddToCartRequested(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
