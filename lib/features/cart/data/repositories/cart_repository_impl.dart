import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/cart/data/datasources/cart_datasource.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/add_to_cart_parameter.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/update_or_remove_parameter.dart';
import 'package:jankuier_mobile/features/cart/domain/repositories/cart_repository.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl implements CartRepository {
  final CartDSInterface _cartDataSource;

  CartRepositoryImpl(this._cartDataSource);

  @override
  Future<Either<Failure, CartActionResponseEntity>> addToCart(
      AddToCartParameter parameter) async {
    try {
      final result = await _cartDataSource.addToCart(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartActionResponseEntity>> updateCartItem(
      UpdateOrRemoveFromCartParameter parameter) async {
    try {
      final result = await _cartDataSource.updateCartItem(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartActionResponseEntity>> clearCart(
      int cartId) async {
    try {
      final result = await _cartDataSource.clearCart(cartId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, CartActionResponseEntity>> myCart(
      bool checkCartItems) async {
    try {
      final result = await _cartDataSource.myCart(checkCartItems);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
