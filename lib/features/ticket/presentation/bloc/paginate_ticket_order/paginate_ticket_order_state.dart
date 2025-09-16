import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/ticket_order/ticket_order_entity.dart';

@immutable
abstract class PaginateTicketOrderState extends Equatable {}

class PaginateTicketOrderInitialState extends PaginateTicketOrderState {
  @override
  List<Object?> get props => [];
}

class PaginateTicketOrderLoadingState extends PaginateTicketOrderState {
  @override
  List<Object?> get props => [];
}

class PaginateTicketOrderFailedState extends PaginateTicketOrderState {
  final Failure failureData;
  PaginateTicketOrderFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class PaginateTicketOrderLoadedState extends PaginateTicketOrderState {
  final Pagination<TicketonOrderEntity> paginationData;
  final List<TicketonOrderEntity> orders;
  PaginateTicketOrderLoadedState(this.paginationData, this.orders);
  @override
  List<Object?> get props => [paginationData, orders];
}