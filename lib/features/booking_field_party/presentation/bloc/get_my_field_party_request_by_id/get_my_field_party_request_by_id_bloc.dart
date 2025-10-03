import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/get_my_field_party_request_by_id.dart';
import 'get_my_field_party_request_by_id_event.dart';
import 'get_my_field_party_request_by_id_state.dart';

@injectable
class GetMyFieldPartyRequestByIdBloc extends Bloc<
    GetMyFieldPartyRequestByIdEvent, GetMyFieldPartyRequestByIdState> {
  final GetMyFieldPartyRequestById _getMyFieldPartyRequestById;

  GetMyFieldPartyRequestByIdBloc({
    required GetMyFieldPartyRequestById getMyFieldPartyRequestById,
  })  : _getMyFieldPartyRequestById = getMyFieldPartyRequestById,
        super(const GetMyFieldPartyRequestByIdInitial()) {
    on<LoadMyFieldPartyRequestById>(_onLoadRequest);
  }

  Future<void> _onLoadRequest(
    LoadMyFieldPartyRequestById event,
    Emitter<GetMyFieldPartyRequestByIdState> emit,
  ) async {
    emit(const GetMyFieldPartyRequestByIdLoading());

    final result = await _getMyFieldPartyRequestById(event.id);

    result.fold(
      (failure) => emit(
          GetMyFieldPartyRequestByIdError(failure.message ?? 'Unknown error')),
      (request) => emit(GetMyFieldPartyRequestByIdSuccess(request)),
    );
  }
}
