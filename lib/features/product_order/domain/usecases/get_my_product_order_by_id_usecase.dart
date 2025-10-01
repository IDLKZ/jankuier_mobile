import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/full_product_order_entity.dart';
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart';

@injectable
class GetMyProductOrderByIdUseCase
    implements UseCase<FullProductOrderEntity, int> {
  final ProductOrderRepository _repository;

  GetMyProductOrderByIdUseCase(this._repository);

  @override
  Future<Either<Failure, FullProductOrderEntity>> call(int params) async {
    return await _repository.myProductOrderById(params);
  }
}
