import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

class CancelOrDeleteProductOrderParams {
  final int productOrderId;
  final bool? isDelete;

  CancelOrDeleteProductOrderParams(this.productOrderId, {this.isDelete});
}

@injectable
class CancelOrDeleteProductOrderUseCase
    implements UseCase<bool, CancelOrDeleteProductOrderParams> {
  final ProductOrderRepository _repository;

  CancelOrDeleteProductOrderUseCase(this._repository);

  @override
  Future<Either<Failure, bool>> call(
      CancelOrDeleteProductOrderParams params) async {
    return await _repository.cancelOrDeleteProductOrder(
        params.productOrderId, params.isDelete);
  }
}
