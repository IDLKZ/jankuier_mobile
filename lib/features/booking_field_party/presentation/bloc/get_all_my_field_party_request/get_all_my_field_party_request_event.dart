import 'package:equatable/equatable.dart';
import '../../../domain/parameters/booking_field_party_request_pagination_parameter.dart';

abstract class GetAllMyFieldPartyRequestEvent extends Equatable {
  const GetAllMyFieldPartyRequestEvent();

  @override
  List<Object?> get props => [];
}

class LoadAllMyFieldPartyRequest extends GetAllMyFieldPartyRequestEvent {
  final BookingFieldPartyRequestPaginationParameter pagination;
  final bool isLoadMore;

  const LoadAllMyFieldPartyRequest(
    this.pagination, {
    this.isLoadMore = false,
  });

  @override
  List<Object?> get props => [pagination, isLoadMore];
}
