import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/usecases/delete_my_field_party_request_by_id.dart';
import 'delete_my_field_party_request_by_id_event.dart';
import 'delete_my_field_party_request_by_id_state.dart';

@injectable
class DeleteMyFieldPartyRequestByIdBloc extends Bloc<
    DeleteMyFieldPartyRequestByIdEvent, DeleteMyFieldPartyRequestByIdState> {
  final DeleteMyFieldPartyRequestById _deleteMyFieldPartyRequestById;

  DeleteMyFieldPartyRequestByIdBloc({
    required DeleteMyFieldPartyRequestById deleteMyFieldPartyRequestById,
  })  : _deleteMyFieldPartyRequestById = deleteMyFieldPartyRequestById,
        super(const DeleteMyFieldPartyRequestByIdInitial()) {
    on<DeleteMyFieldPartyRequestByIdStarted>(_onDeleteRequest);
  }

  Future<void> _onDeleteRequest(
    DeleteMyFieldPartyRequestByIdStarted event,
    Emitter<DeleteMyFieldPartyRequestByIdState> emit,
  ) async {
    emit(const DeleteMyFieldPartyRequestByIdLoading());

    final params = DeleteMyFieldPartyRequestParams(
      id: event.id,
      forceDelete: event.forceDelete,
    );

    final result = await _deleteMyFieldPartyRequestById(params);

    result.fold(
      (failure) => emit(DeleteMyFieldPartyRequestByIdError(
          failure.message ?? 'Unknown error')),
      (_) => emit(DeleteMyFieldPartyRequestByIdSuccess(event.id)),
    );
  }
}
