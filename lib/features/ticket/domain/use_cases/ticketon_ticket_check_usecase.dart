import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticketon_ticket_check_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/ticketon_ticket_check_parameter.dart';

@injectable
class TicketonTicketCheckUseCase
    implements UseCase<TicketonTicketCheckCommonResponseEntity, TicketonTicketCheckParameter> {
  final TicketonOrderRepository _repository;

  const TicketonTicketCheckUseCase(this._repository);

  @override
  Future<Either<Failure, TicketonTicketCheckCommonResponseEntity>> call(
      TicketonTicketCheckParameter params) async {
    return await _repository.ticketonTicketCheck(
      params.ticketOrderId,
      params.ticketId,
    );
  }
}