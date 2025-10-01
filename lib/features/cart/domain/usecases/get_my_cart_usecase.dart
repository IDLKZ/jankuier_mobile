import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/cart/data/entities/cart_action_response_entity.dart';
import 'package:jankuier_mobile/features/cart/domain/repositories/cart_repository.dart';

@injectable
class GetMyCartUseCase implements UseCase<CartActionResponseEntity, bool> {
  final CartRepository _repository;

  GetMyCartUseCase(this._repository);

  @override
  Future<Either<Failure, CartActionResponseEntity>> call(bool params) async {
    return await _repository.myCart(params);
  }
}
