import 'package:dartz/dartz.dart';
import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../data/entities/booking_field_party_request_entity.dart';
import '../../data/entities/create_booking_field_party_response_entity.dart';
import '../parameters/booking_field_party_request_pagination_parameter.dart';
import '../parameters/create_booking_field_party_request_parameter.dart';

abstract class BookingFieldPartyRepository {
  Future<Either<Failure, CreateBookingFieldPartyResponseEntity>>
      createBookingFieldRequest(
          CreateBookingFieldPartyRequestParameter parameter);

  Future<Either<Failure, BookingFieldPartyRequestEntity>>
      getMyFieldPartyRequestById(int id);

  Future<Either<Failure, Pagination<BookingFieldPartyRequestEntity>>>
      getAllMyFieldPartyRequest(
          BookingFieldPartyRequestPaginationParameter pagination);

  Future<Either<Failure, bool>> deleteMyFieldPartyRequestById(
      int id, bool forceDelete);
}
