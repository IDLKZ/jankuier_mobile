import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';

abstract class GetMyProductOrderItemsByIdState extends Equatable {
  const GetMyProductOrderItemsByIdState();

  @override
  List<Object?> get props => [];
}

class GetMyProductOrderItemsByIdInitial
    extends GetMyProductOrderItemsByIdState {
  const GetMyProductOrderItemsByIdInitial();
}

class GetMyProductOrderItemsByIdLoading
    extends GetMyProductOrderItemsByIdState {
  const GetMyProductOrderItemsByIdLoading();
}

class GetMyProductOrderItemsByIdLoaded extends GetMyProductOrderItemsByIdState {
  final Pagination<ProductOrderItemEntity> items;

  const GetMyProductOrderItemsByIdLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class GetMyProductOrderItemsByIdError extends GetMyProductOrderItemsByIdState {
  final String message;

  const GetMyProductOrderItemsByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
