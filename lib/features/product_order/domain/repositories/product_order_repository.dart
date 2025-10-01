import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/full_product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_status_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_response_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_status_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_item_pagination_parameter.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_item_status_all_parameter.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_pagination_parameter.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_status_all_parameter.dart';

abstract class ProductOrderRepository {
  Future<Either<Failure, List<ProductOrderStatusEntity>>>
      getAllProductOrderStatus(ProductOrderStatusFilterParameter parameter);

  Future<Either<Failure, List<ProductOrderItemStatusEntity>>>
      getAllProductOrderItemStatus(
          ProductOrderItemStatusFilterParameter parameter);

  Future<Either<Failure, ProductOrderResponseEntity>> createProductFromCart(
      String? phone, String? email);

  Future<Either<Failure, Pagination<ProductOrderEntity>>> myProductOrders(
      ProductOrderPaginationParameter parameter);

  Future<Either<Failure, FullProductOrderEntity>> myProductOrderById(
      int productOrderId);

  Future<Either<Failure, Pagination<ProductOrderItemEntity>>>
      myProductOrderItemById(
          int productOrderId, ProductOrderItemPaginationParameter parameter);

  Future<Either<Failure, bool>> cancelOrDeleteProductOrder(
      int productOrderId, bool? isDelete);

  Future<Either<Failure, ProductOrderItemEntity?>> cancelOrderItem(
      int productOrderItemId);
}
