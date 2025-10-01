import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/add_to_cart_parameter.dart';
import 'package:jankuier_mobile/features/cart/domain/repositories/cart_repository.dart';

@injectable
class AddToCartUseCase
    implements UseCase<CartActionResponseEntity, AddToCartParameter> {
  final CartRepository _repository;

  AddToCartUseCase(this._repository);

  @override
  Future<Either<Failure, CartActionResponseEntity>> call(
      AddToCartParameter params) async {
    return await _repository.addToCart(params);
  }
}
