import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/entities/create_booking_field_party_response_entity.dart';
import '../parameters/create_booking_field_party_request_parameter.dart';
import '../repositories/booking_field_party_repository.dart';

@injectable
class CreateBookingFieldPartyRequest
    implements
        UseCase<CreateBookingFieldPartyResponseEntity,
            CreateBookingFieldPartyRequestParameter> {
  final BookingFieldPartyRepository repository;

  CreateBookingFieldPartyRequest(this.repository);

  @override
  Future<Either<Failure, CreateBookingFieldPartyResponseEntity>> call(
      CreateBookingFieldPartyRequestParameter params) async {
    return await repository.createBookingFieldRequest(params);
  }
}
