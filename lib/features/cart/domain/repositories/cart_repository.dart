import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/add_to_cart_parameter.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/update_or_remove_parameter.dart';

abstract class CartRepository {
  Future<Either<Failure, CartActionResponseEntity>> addToCart(
      AddToCartParameter parameter);

  Future<Either<Failure, CartActionResponseEntity>> updateCartItem(
      UpdateOrRemoveFromCartParameter parameter);

  Future<Either<Failure, CartActionResponseEntity>> clearCart(int cartId);

  Future<Either<Failure, CartActionResponseEntity>> myCart(bool checkCartItems);
}
