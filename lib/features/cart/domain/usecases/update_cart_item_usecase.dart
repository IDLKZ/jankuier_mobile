import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/parameters/update_or_remove_parameter.dart';
import 'package:jankuier_mobile/features/cart/domain/repositories/cart_repository.dart';

@injectable
class UpdateCartItemUseCase
    implements
        UseCase<CartActionResponseEntity, UpdateOrRemoveFromCartParameter> {
  final CartRepository _repository;

  UpdateCartItemUseCase(this._repository);

  @override
  Future<Either<Failure, CartActionResponseEntity>> call(
      UpdateOrRemoveFromCartParameter params) async {
    return await _repository.updateCartItem(params);
  }
}
