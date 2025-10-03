import 'package:equatable/equatable.dart';
import '../../../../../core/common/entities/pagination_entity.dart';
import '../../../data/entities/booking_field_party_request_entity.dart';

abstract class GetAllMyFieldPartyRequestState extends Equatable {
  const GetAllMyFieldPartyRequestState();

  @override
  List<Object?> get props => [];
}

class GetAllMyFieldPartyRequestInitial extends GetAllMyFieldPartyRequestState {
  const GetAllMyFieldPartyRequestInitial();
}

class GetAllMyFieldPartyRequestLoading extends GetAllMyFieldPartyRequestState {
  final bool isLoadingMore;

  const GetAllMyFieldPartyRequestLoading({this.isLoadingMore = false});

  @override
  List<Object?> get props => [isLoadingMore];
}

class GetAllMyFieldPartyRequestSuccess extends GetAllMyFieldPartyRequestState {
  final Pagination<BookingFieldPartyRequestEntity> pagination;

  const GetAllMyFieldPartyRequestSuccess(this.pagination);

  @override
  List<Object?> get props => [pagination];
}

class GetAllMyFieldPartyRequestError extends GetAllMyFieldPartyRequestState {
  final String message;

  const GetAllMyFieldPartyRequestError(this.message);

  @override
  List<Object?> get props => [message];
}
