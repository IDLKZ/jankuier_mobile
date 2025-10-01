import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';

abstract class AddToCartState extends Equatable {
  const AddToCartState();

  @override
  List<Object?> get props => [];
}

class AddToCartInitial extends AddToCartState {
  const AddToCartInitial();
}

class AddToCartLoading extends AddToCartState {
  const AddToCartLoading();
}

class AddToCartSuccess extends AddToCartState {
  final CartActionResponseEntity response;

  const AddToCartSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class AddToCartError extends AddToCartState {
  final String message;

  const AddToCartError(this.message);

  @override
  List<Object?> get props => [message];
}
