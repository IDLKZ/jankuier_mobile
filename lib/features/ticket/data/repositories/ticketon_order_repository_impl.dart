import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticketon_order_check_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticketon_ticket_check_entity.dart';
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_ticketon_order_parameter.dart';

@Injectable(as: TicketonOrderRepository)
class TicketonOrderRepositoryImpl implements TicketonOrderRepository {
  final TicketonOrderDSInterface _dataSource;

  const TicketonOrderRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Pagination<TicketonOrderEntity>>> paginateTicketOrder(
      PaginateTicketonOrderParameter parameter) async {
    try {
      final result = await _dataSource.paginateTicketOrder(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketonOrderEntity>> getTicketOrder(
      int ticketOrderId) async {
    try {
      final result = await _dataSource.getTicketOrder(ticketOrderId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketonOrderCheckCommonResponseEntity>> ticketonOrderCheck(
      int ticketOrderId) async {
    try {
      final result = await _dataSource.ticketonOrderCheck(ticketOrderId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, TicketonTicketCheckCommonResponseEntity>> ticketonTicketCheck(
      int ticketOrderId, String ticketId) async {
    try {
      final result = await _dataSource.ticketonTicketCheck(ticketOrderId, ticketId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}