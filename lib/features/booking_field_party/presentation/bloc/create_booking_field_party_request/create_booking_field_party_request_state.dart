import 'package:equatable/equatable.dart';
import '../../../data/entities/create_booking_field_party_response_entity.dart';

abstract class CreateBookingFieldPartyRequestState extends Equatable {
  const CreateBookingFieldPartyRequestState();

  @override
  List<Object?> get props => [];
}

class CreateBookingFieldPartyRequestInitial
    extends CreateBookingFieldPartyRequestState {
  const CreateBookingFieldPartyRequestInitial();
}

class CreateBookingFieldPartyRequestLoading
    extends CreateBookingFieldPartyRequestState {
  const CreateBookingFieldPartyRequestLoading();
}

class CreateBookingFieldPartyRequestSuccess
    extends CreateBookingFieldPartyRequestState {
  final CreateBookingFieldPartyResponseEntity response;

  const CreateBookingFieldPartyRequestSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class CreateBookingFieldPartyRequestError
    extends CreateBookingFieldPartyRequestState {
  final String message;

  const CreateBookingFieldPartyRequestError(this.message);

  @override
  List<Object?> get props => [message];
}
