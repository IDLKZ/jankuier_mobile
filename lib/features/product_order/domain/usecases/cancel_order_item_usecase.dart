import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

@injectable
class CancelOrderItemUseCase implements UseCase<ProductOrderItemEntity?, int> {
  final ProductOrderRepository _repository;

  CancelOrderItemUseCase(this._repository);

  @override
  Future<Either<Failure, ProductOrderItemEntity?>> call(int params) async {
    return await _repository.cancelOrderItem(params);
  }
}
