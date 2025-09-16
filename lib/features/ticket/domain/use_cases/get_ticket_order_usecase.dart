import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart';

@injectable
class GetTicketOrderUseCase implements UseCase<TicketonOrderEntity, int> {
  final TicketonOrderRepository _repository;

  const GetTicketOrderUseCase(this._repository);

  @override
  Future<Either<Failure, TicketonOrderEntity>> call(int params) async {
    return await _repository.getTicketOrder(params);
  }
}