import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_pagination_parameter.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

@injectable
class GetMyProductOrdersUseCase
    implements
        UseCase<Pagination<ProductOrderEntity>,
            ProductOrderPaginationParameter> {
  final ProductOrderRepository _repository;

  GetMyProductOrdersUseCase(this._repository);

  @override
  Future<Either<Failure, Pagination<ProductOrderEntity>>> call(
      ProductOrderPaginationParameter params) async {
    return await _repository.myProductOrders(params);
  }
}
