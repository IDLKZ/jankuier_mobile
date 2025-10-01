import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/full_product_order_entity.dart';

abstract class GetMyProductOrderByIdState extends Equatable {
  const GetMyProductOrderByIdState();

  @override
  List<Object?> get props => [];
}

class GetMyProductOrderByIdInitial extends GetMyProductOrderByIdState {
  const GetMyProductOrderByIdInitial();
}

class GetMyProductOrderByIdLoading extends GetMyProductOrderByIdState {
  const GetMyProductOrderByIdLoading();
}

class GetMyProductOrderByIdLoaded extends GetMyProductOrderByIdState {
  final FullProductOrderEntity order;

  const GetMyProductOrderByIdLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

class GetMyProductOrderByIdError extends GetMyProductOrderByIdState {
  final String message;

  const GetMyProductOrderByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
