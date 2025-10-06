import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_response_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_status_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_status_all_parameter.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../domain/parameters/product_order_item_pagination_parameter.dart';
import '../../domain/parameters/product_order_item_status_all_parameter.dart';
import '../../domain/parameters/product_order_pagination_parameter.dart';
import '../entities/full_product_order_entity.dart';
import '../entities/product_order_item_status_entity.dart';

abstract class ProductOrderDSInterface {
  Future<List<ProductOrderStatusEntity>> getAllProductOrderStatus(
      ProductOrderStatusFilterParameter parameter);
  Future<List<ProductOrderItemStatusEntity>> getAllProductOrderItemStatus(
      ProductOrderItemStatusFilterParameter parameter);
  Future<ProductOrderResponseEntity> createProductFromCart(
      String? phone, String? email);
  Future<Pagination<ProductOrderEntity>> myProductOrders(
      ProductOrderPaginationParameter parameter);
  Future<FullProductOrderEntity> myProductOrderById(int productOrderId);
  Future<Pagination<ProductOrderItemEntity>> myProductOrderItemById(
      int productOrderId, ProductOrderItemPaginationParameter parameter);
  Future<bool> cancelOrDeleteProductOrder(int productOrderId, bool? isDelete);
  Future<ProductOrderItemEntity?> cancelOrderItem(int productOrderItemId);
}

class ProductOrderDSImpl implements ProductOrderDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<bool> cancelOrDeleteProductOrder(
      int productOrderId, bool? isDelete) async {
    try {
      final response = await httpUtils.delete(
          ApiConstant.CancelOrDeleteProductOrderByIdDelete(productOrderId),
          data: {"is_delete": isDelete ?? false});
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ProductOrderItemEntity?> cancelOrderItem(
      int productOrderItemId) async {
    try {
      final response = await httpUtils
          .post(ApiConstant.CancelProductOrderItemByIdPost(productOrderItemId));
      final result = ProductOrderItemEntity?.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ProductOrderResponseEntity> createProductFromCart(
      String? phone, String? email) async {
    try {
      final response = await httpUtils.post(
          ApiConstant.createProductOrderFromCartPost,
          data: {"phone": phone, "email": email});
      final result = ProductOrderResponseEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductOrderItemStatusEntity>> getAllProductOrderItemStatus(
      ProductOrderItemStatusFilterParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.allProductOrderItemStatusGet,
          queryParameters: parameter.toQueryParameters());
      final result = ProductOrderItemStatusListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<ProductOrderStatusEntity>> getAllProductOrderStatus(
      ProductOrderStatusFilterParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.allProductOrderStatusGet,
          queryParameters: parameter.toQueryParameters());
      final result = ProductOrderStatusListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<FullProductOrderEntity> myProductOrderById(int productOrderId) async {
    try {
      final response = await httpUtils
          .get(ApiConstant.GetMyProductOrderByOrderIdGet(productOrderId));
      final result = FullProductOrderEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<ProductOrderItemEntity>> myProductOrderItemById(
      int productOrderId, ProductOrderItemPaginationParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.GetMyProductOrderItemsByOrderIdGet(productOrderId),
          queryParameters: parameter.toQueryParameters());
      final result = Pagination<ProductOrderItemEntity>.fromJson(
          response, ProductOrderItemEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<ProductOrderEntity>> myProductOrders(
      ProductOrderPaginationParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.paginateMyProductOrdersGet,
          queryParameters: parameter.toQueryParameters());
      final result = Pagination<ProductOrderEntity>.fromJson(
          response, ProductOrderEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
