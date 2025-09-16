import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticketon_order_check_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticketon_ticket_check_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_ticketon_order_parameter.dart';

abstract class TicketonOrderRepository {
  Future<Either<Failure, Pagination<TicketonOrderEntity>>> paginateTicketOrder(
      PaginateTicketonOrderParameter parameter);

  Future<Either<Failure, TicketonOrderEntity>> getTicketOrder(int ticketOrderId);

  Future<Either<Failure, TicketonOrderCheckCommonResponseEntity>> ticketonOrderCheck(
      int ticketOrderId);

  Future<Either<Failure, TicketonTicketCheckCommonResponseEntity>> ticketonTicketCheck(
      int ticketOrderId, String ticketId);
}