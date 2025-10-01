import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';

abstract class MyCartState extends Equatable {
  const MyCartState();

  @override
  List<Object?> get props => [];
}

class MyCartInitial extends MyCartState {
  const MyCartInitial();
}

class MyCartLoading extends MyCartState {
  const MyCartLoading();
}

class MyCartLoaded extends MyCartState {
  final CartActionResponseEntity response;

  const MyCartLoaded(this.response);

  @override
  List<Object?> get props => [response];
}

class MyCartError extends MyCartState {
  final String message;

  const MyCartError(this.message);

  @override
  List<Object?> get props => [message];
}
