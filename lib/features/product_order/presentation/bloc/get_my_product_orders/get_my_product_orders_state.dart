import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';

abstract class GetMyProductOrdersState extends Equatable {
  const GetMyProductOrdersState();

  @override
  List<Object?> get props => [];
}

class GetMyProductOrdersInitial extends GetMyProductOrdersState {
  const GetMyProductOrdersInitial();
}

class GetMyProductOrdersLoading extends GetMyProductOrdersState {
  const GetMyProductOrdersLoading();
}

class GetMyProductOrdersLoaded extends GetMyProductOrdersState {
  final Pagination<ProductOrderEntity> orders;

  const GetMyProductOrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

class GetMyProductOrdersError extends GetMyProductOrdersState {
  final String message;

  const GetMyProductOrdersError(this.message);

  @override
  List<Object?> get props => [message];
}
