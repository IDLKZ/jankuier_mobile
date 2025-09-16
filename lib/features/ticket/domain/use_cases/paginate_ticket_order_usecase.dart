import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_ticketon_order_parameter.dart';

@injectable
class PaginateTicketOrderUseCase
    implements UseCase<Pagination<TicketonOrderEntity>, PaginateTicketonOrderParameter> {
  final TicketonOrderRepository _repository;

  const PaginateTicketOrderUseCase(this._repository);

  @override
  Future<Either<Failure, Pagination<TicketonOrderEntity>>> call(
      PaginateTicketonOrderParameter params) async {
    return await _repository.paginateTicketOrder(params);
  }
}