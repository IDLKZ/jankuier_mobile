import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_response_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

class CreateProductOrderParams {
  final String? phone;
  final String? email;

  CreateProductOrderParams({this.phone, this.email});
}

@injectable
class CreateProductOrderFromCartUseCase
    implements UseCase<ProductOrderResponseEntity, CreateProductOrderParams> {
  final ProductOrderRepository _repository;

  CreateProductOrderFromCartUseCase(this._repository);

  @override
  Future<Either<Failure, ProductOrderResponseEntity>> call(
      CreateProductOrderParams params) async {
    return await _repository.createProductFromCart(params.phone, params.email);
  }
}
