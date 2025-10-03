import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/entities/booking_field_party_request_entity.dart';
import '../repositories/booking_field_party_repository.dart';

@injectable
class GetMyFieldPartyRequestById
    implements UseCase<BookingFieldPartyRequestEntity, int> {
  final BookingFieldPartyRepository repository;

  GetMyFieldPartyRequestById(this.repository);

  @override
  Future<Either<Failure, BookingFieldPartyRequestEntity>> call(
      int params) async {
    return await repository.getMyFieldPartyRequestById(params);
  }
}
