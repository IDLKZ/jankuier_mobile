import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_response_entity.dart';

abstract class CreateProductOrderFromCartState extends Equatable {
  const CreateProductOrderFromCartState();

  @override
  List<Object?> get props => [];
}

class CreateProductOrderFromCartInitial
    extends CreateProductOrderFromCartState {
  const CreateProductOrderFromCartInitial();
}

class CreateProductOrderFromCartLoading
    extends CreateProductOrderFromCartState {
  const CreateProductOrderFromCartLoading();
}

class CreateProductOrderFromCartSuccess
    extends CreateProductOrderFromCartState {
  final ProductOrderResponseEntity response;

  const CreateProductOrderFromCartSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateProductOrderFromCartError extends CreateProductOrderFromCartState {
  final String message;

  const CreateProductOrderFromCartError(this.message);

  @override
  List<Object?> get props => [message];
}
