import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_item_pagination_parameter.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

class GetMyProductOrderItemsByIdParams {
  final int productOrderId;
  final ProductOrderItemPaginationParameter parameter;

  GetMyProductOrderItemsByIdParams(this.productOrderId, this.parameter);
}

@injectable
class GetMyProductOrderItemsByIdUseCase
    implements
        UseCase<Pagination<ProductOrderItemEntity>,
            GetMyProductOrderItemsByIdParams> {
  final ProductOrderRepository _repository;

  GetMyProductOrderItemsByIdUseCase(this._repository);

  @override
  Future<Either<Failure, Pagination<ProductOrderItemEntity>>> call(
      GetMyProductOrderItemsByIdParams params) async {
    return await _repository.myProductOrderItemById(
        params.productOrderId, params.parameter);
  }
}
