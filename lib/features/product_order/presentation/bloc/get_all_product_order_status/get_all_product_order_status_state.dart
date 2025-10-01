import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_status_entity.dart';

abstract class GetAllProductOrderStatusState extends Equatable {
  const GetAllProductOrderStatusState();

  @override
  List<Object?> get props => [];
}

class GetAllProductOrderStatusInitial extends GetAllProductOrderStatusState {
  const GetAllProductOrderStatusInitial();
}

class GetAllProductOrderStatusLoading extends GetAllProductOrderStatusState {
  const GetAllProductOrderStatusLoading();
}

class GetAllProductOrderStatusLoaded extends GetAllProductOrderStatusState {
  final List<ProductOrderStatusEntity> statuses;

  const GetAllProductOrderStatusLoaded(this.statuses);

  @override
  List<Object?> get props => [statuses];
}

class GetAllProductOrderStatusError extends GetAllProductOrderStatusState {
  final String message;

  const GetAllProductOrderStatusError(this.message);

  @override
  List<Object?> get props => [message];
}
