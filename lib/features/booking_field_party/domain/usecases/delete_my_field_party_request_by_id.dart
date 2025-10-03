import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/booking_field_party_repository.dart';

class DeleteMyFieldPartyRequestParams extends Equatable {
  final int id;
  final bool forceDelete;

  const DeleteMyFieldPartyRequestParams({
    required this.id,
    required this.forceDelete,
  });

  @override
  List<Object?> get props => [id, forceDelete];
}

@injectable
class DeleteMyFieldPartyRequestById
    implements UseCase<bool, DeleteMyFieldPartyRequestParams> {
  final BookingFieldPartyRepository repository;

  DeleteMyFieldPartyRequestById(this.repository);

  @override
  Future<Either<Failure, bool>> call(
      DeleteMyFieldPartyRequestParams params) async {
    return await repository.deleteMyFieldPartyRequestById(
        params.id, params.forceDelete);
  }
}
