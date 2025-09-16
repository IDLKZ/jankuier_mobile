import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/ticket_order/ticket_order_entity.dart';

@immutable
abstract class GetTicketOrderState extends Equatable {}

class GetTicketOrderInitialState extends GetTicketOrderState {
  @override
  List<Object?> get props => [];
}

class GetTicketOrderLoadingState extends GetTicketOrderState {
  @override
  List<Object?> get props => [];
}

class GetTicketOrderFailedState extends GetTicketOrderState {
  final Failure failureData;
  GetTicketOrderFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class GetTicketOrderSuccessState extends GetTicketOrderState {
  final TicketonOrderEntity ticketOrder;
  GetTicketOrderSuccessState(this.ticketOrder);
  @override
  List<Object?> get props => [ticketOrder];
}