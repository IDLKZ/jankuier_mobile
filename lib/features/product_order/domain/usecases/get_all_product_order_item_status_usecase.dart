import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_status_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/parameters/product_order_item_status_all_parameter.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

@injectable
class GetAllProductOrderItemStatusUseCase
    implements
        UseCase<List<ProductOrderItemStatusEntity>,
            ProductOrderItemStatusFilterParameter> {
  final ProductOrderRepository _repository;

  GetAllProductOrderItemStatusUseCase(this._repository);

  @override
  Future<Either<Failure, List<ProductOrderItemStatusEntity>>> call(
      ProductOrderItemStatusFilterParameter params) async {
    return await _repository.getAllProductOrderItemStatus(params);
  }
}
