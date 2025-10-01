import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/product_order/data/datasources/product_order_datasource.dart';
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
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

@Injectable(as: ProductOrderRepository)
class ProductOrderRepositoryImpl implements ProductOrderRepository {
  final ProductOrderDSInterface _dataSource;

  ProductOrderRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, List<ProductOrderStatusEntity>>>
      getAllProductOrderStatus(
          ProductOrderStatusFilterParameter parameter) async {
    try {
      final result = await _dataSource.getAllProductOrderStatus(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductOrderItemStatusEntity>>>
      getAllProductOrderItemStatus(
          ProductOrderItemStatusFilterParameter parameter) async {
    try {
      final result = await _dataSource.getAllProductOrderItemStatus(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductOrderResponseEntity>> createProductFromCart(
      String? phone, String? email) async {
    try {
      final result = await _dataSource.createProductFromCart(phone, email);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<ProductOrderEntity>>> myProductOrders(
      ProductOrderPaginationParameter parameter) async {
    try {
      final result = await _dataSource.myProductOrders(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, FullProductOrderEntity>> myProductOrderById(
      int productOrderId) async {
    try {
      final result = await _dataSource.myProductOrderById(productOrderId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<ProductOrderItemEntity>>>
      myProductOrderItemById(int productOrderId,
          ProductOrderItemPaginationParameter parameter) async {
    try {
      final result =
          await _dataSource.myProductOrderItemById(productOrderId, parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> cancelOrDeleteProductOrder(
      int productOrderId, bool? isDelete) async {
    try {
      final result = await _dataSource.cancelOrDeleteProductOrder(
          productOrderId, isDelete);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductOrderItemEntity?>> cancelOrderItem(
      int productOrderItemId) async {
    try {
      final result = await _dataSource.cancelOrderItem(productOrderItemId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
