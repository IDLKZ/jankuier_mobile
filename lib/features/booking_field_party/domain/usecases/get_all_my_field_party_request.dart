import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/entities/booking_field_party_request_entity.dart';
import '../parameters/booking_field_party_request_pagination_parameter.dart';
import '../repositories/booking_field_party_repository.dart';

@injectable
class GetAllMyFieldPartyRequest
    implements
        UseCase<Pagination<BookingFieldPartyRequestEntity>,
            BookingFieldPartyRequestPaginationParameter> {
  final BookingFieldPartyRepository repository;

  GetAllMyFieldPartyRequest(this.repository);

  @override
  Future<Either<Failure, Pagination<BookingFieldPartyRequestEntity>>> call(
      BookingFieldPartyRequestPaginationParameter params) async {
    return await repository.getAllMyFieldPartyRequest(params);
  }
}
