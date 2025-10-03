import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/usecases/create_booking_field_party_request.dart';
import 'create_booking_field_party_request_event.dart';
import 'create_booking_field_party_request_state.dart';

@injectable
class CreateBookingFieldPartyRequestBloc extends Bloc<
    CreateBookingFieldPartyRequestEvent, CreateBookingFieldPartyRequestState> {
  final CreateBookingFieldPartyRequest _createBookingFieldPartyRequest;

  CreateBookingFieldPartyRequestBloc({
    required CreateBookingFieldPartyRequest createBookingFieldPartyRequest,
  })  : _createBookingFieldPartyRequest = createBookingFieldPartyRequest,
        super(const CreateBookingFieldPartyRequestInitial()) {
    on<CreateBookingFieldPartyRequestSubmitted>(_onCreateRequest);
  }

  Future<void> _onCreateRequest(
    CreateBookingFieldPartyRequestSubmitted event,
    Emitter<CreateBookingFieldPartyRequestState> emit,
  ) async {
    emit(const CreateBookingFieldPartyRequestLoading());

    final result = await _createBookingFieldPartyRequest(event.parameter);

    result.fold(
      (failure) => emit(CreateBookingFieldPartyRequestError(
          failure.message ?? 'Unknown error')),
      (response) => emit(CreateBookingFieldPartyRequestSuccess(response)),
    );
  }
}
