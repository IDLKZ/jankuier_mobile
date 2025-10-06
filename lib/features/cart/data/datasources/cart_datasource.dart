import 'package:dio/dio.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/add_to_cart_parameter.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/update_or_remove_parameter.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';

abstract class CartDSInterface {
  Future<CartActionResponseEntity> addToCart(AddToCartParameter parameter);
  Future<CartActionResponseEntity> updateCartItem(
      UpdateOrRemoveFromCartParameter parameter);
  Future<CartActionResponseEntity> clearCart(int cartId);
  Future<CartActionResponseEntity> myCart(bool checkCartItems);
}

class CartDSImpl implements CartDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<CartActionResponseEntity> addToCart(
      AddToCartParameter parameter) async {
    try {
      final response =
          await httpUtils.post(ApiConstant.addToCart, data: parameter.toJson());
      final result = CartActionResponseEntity.fromJson(response);
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
  Future<CartActionResponseEntity> clearCart(int cartId) async {
    try {
      final response =
          await httpUtils.delete(ApiConstant.clearCart + cartId.toString());
      final result = CartActionResponseEntity.fromJson(response);
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
  Future<CartActionResponseEntity> myCart(bool checkCartItems) async {
    try {
      final response = await httpUtils.get(ApiConstant.myCart,
          queryParameters: {"check_cart_items": checkCartItems.toString()});
      final result = CartActionResponseEntity.fromJson(response);
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
  Future<CartActionResponseEntity> updateCartItem(
      UpdateOrRemoveFromCartParameter parameter) async {
    try {
      final response = await httpUtils.put(ApiConstant.updateCartItem,
          data: parameter.toJson());
      final result = CartActionResponseEntity.fromJson(response);
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
