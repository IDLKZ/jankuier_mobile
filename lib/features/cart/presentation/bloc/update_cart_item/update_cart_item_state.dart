import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';

abstract class UpdateCartItemState extends Equatable {
  const UpdateCartItemState();

  @override
  List<Object?> get props => [];
}

class UpdateCartItemInitial extends UpdateCartItemState {
  const UpdateCartItemInitial();
}

class UpdateCartItemLoading extends UpdateCartItemState {
  const UpdateCartItemLoading();
}

class UpdateCartItemSuccess extends UpdateCartItemState {
  final CartActionResponseEntity response;

  const UpdateCartItemSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class UpdateCartItemError extends UpdateCartItemState {
  final String message;

  const UpdateCartItemError(this.message);

  @override
  List<Object?> get props => [message];
}
