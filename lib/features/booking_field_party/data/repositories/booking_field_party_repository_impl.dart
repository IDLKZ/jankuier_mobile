import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/booking_field_party/data/datasources/booking_field_party_datasource.dart';
import 'package:jankuier_mobile/features/booking_field_party/data/entities/booking_field_party_request_entity.dart';
import 'package:jankuier_mobile/features/booking_field_party/data/entities/create_booking_field_party_response_entity.dart';
import 'package:jankuier_mobile/features/booking_field_party/domain/parameters/booking_field_party_request_pagination_parameter.dart';
import 'package:jankuier_mobile/features/booking_field_party/domain/parameters/create_booking_field_party_request_parameter.dart';
import 'package:jankuier_mobile/features/booking_field_party/domain/repositories/booking_field_party_repository.dart';

@Injectable(as: BookingFieldPartyRepository)
class BookingFieldPartyRepositoryImpl implements BookingFieldPartyRepository {
  final BookingFieldPartyDSInterface _dataSource;

  BookingFieldPartyRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, CreateBookingFieldPartyResponseEntity>>
      createBookingFieldRequest(
          CreateBookingFieldPartyRequestParameter parameter) async {
    try {
      final result = await _dataSource.createBookingFieldRequest(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, BookingFieldPartyRequestEntity>>
      getMyFieldPartyRequestById(int id) async {
    try {
      final result = await _dataSource.getMyFieldPartyRequestById(id);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Pagination<BookingFieldPartyRequestEntity>>>
      getAllMyFieldPartyRequest(
          BookingFieldPartyRequestPaginationParameter pagination) async {
    try {
      final result = await _dataSource.getAllMyFieldPartyRequest(pagination);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteMyFieldPartyRequestById(
      int id, bool forceDelete) async {
    try {
      final result =
          await _dataSource.deleteMyFieldPartyRequestById(id, forceDelete);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
