import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticketon_order_check_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart';

@injectable
class TicketonOrderCheckUseCase
    implements UseCase<TicketonOrderCheckCommonResponseEntity, int> {
  final TicketonOrderRepository _repository;

  const TicketonOrderCheckUseCase(this._repository);

  @override
  Future<Either<Failure, TicketonOrderCheckCommonResponseEntity>> call(
      int params) async {
    return await _repository.ticketonOrderCheck(params);
  }
}