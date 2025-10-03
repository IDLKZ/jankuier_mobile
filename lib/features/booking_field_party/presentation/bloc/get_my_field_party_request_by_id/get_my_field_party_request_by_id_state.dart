import 'package:equatable/equatable.dart';
import '../../../data/entities/booking_field_party_request_entity.dart';

abstract class GetMyFieldPartyRequestByIdState extends Equatable {
  const GetMyFieldPartyRequestByIdState();

  @override
  List<Object?> get props => [];
}

class GetMyFieldPartyRequestByIdInitial
    extends GetMyFieldPartyRequestByIdState {
  const GetMyFieldPartyRequestByIdInitial();
}

class GetMyFieldPartyRequestByIdLoading
    extends GetMyFieldPartyRequestByIdState {
  const GetMyFieldPartyRequestByIdLoading();
}

class GetMyFieldPartyRequestByIdSuccess
    extends GetMyFieldPartyRequestByIdState {
  final BookingFieldPartyRequestEntity request;

  const GetMyFieldPartyRequestByIdSuccess(this.request);

  @override
  List<Object?> get props => [request];
}

class GetMyFieldPartyRequestByIdError extends GetMyFieldPartyRequestByIdState {
  final String message;

  const GetMyFieldPartyRequestByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
