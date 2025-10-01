import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';

abstract class ClearCartState extends Equatable {
  const ClearCartState();

  @override
  List<Object?> get props => [];
}

class ClearCartInitial extends ClearCartState {
  const ClearCartInitial();
}

class ClearCartLoading extends ClearCartState {
  const ClearCartLoading();
}

class ClearCartSuccess extends ClearCartState {
  final CartActionResponseEntity response;

  const ClearCartSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class ClearCartError extends ClearCartState {
  final String message;

  const ClearCartError(this.message);

  @override
  List<Object?> get props => [message];
}
