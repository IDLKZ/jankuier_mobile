import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import 'package:jankuier_mobile/features/ticket/datasources/yandex_afisha_ticket_datasource.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/yandex_afisha_ticket_repository.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/all_yandex_afisha_ticket_parameter.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_yandex_afisha_parameter.dart';

@Injectable(as: YandexAfishaTicketRepository)
class YandexAfishaTicketRepositoryImpl implements YandexAfishaTicketRepository {
  final YandexAfishaTicketDSInterface _dataSource;

  const YandexAfishaTicketRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, Pagination<YandexAfishaWidgetTicketEntity>>> paginateTickets(
      YandexAfishaWidgetTicketPaginationParameter parameter) async {
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
  Future<Either<Failure, List<YandexAfishaWidgetTicketEntity>>> getAllTickets(
      AllYandexAfishaWidgetTicketFilterParameter parameter) async {
    try {
      final result = await _dataSource.allTicketOrder(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, YandexAfishaWidgetTicketEntity>> getTicketById(
      int yandexAfishaId) async {
    try {
      final result = await _dataSource.getYandexAfishaEntity(yandexAfishaId);
      return Right(result);
    } on ApiException catch (e) {
      return Left(FailureMapper.fromApiException(e));
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
}
