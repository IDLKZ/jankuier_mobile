import 'package:equatable/equatable.dart';
import '../../../domain/parameters/create_booking_field_party_request_parameter.dart';

abstract class CreateBookingFieldPartyRequestEvent extends Equatable {
  const CreateBookingFieldPartyRequestEvent();

  @override
  List<Object?> get props => [];
}

class CreateBookingFieldPartyRequestSubmitted
    extends CreateBookingFieldPartyRequestEvent {
  final CreateBookingFieldPartyRequestParameter parameter;

  const CreateBookingFieldPartyRequestSubmitted(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
