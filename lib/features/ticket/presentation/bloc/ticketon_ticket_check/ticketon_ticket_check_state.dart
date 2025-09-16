import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/ticket_order/ticketon_ticket_check_entity.dart';

@immutable
abstract class TicketonTicketCheckState extends Equatable {}

class TicketonTicketCheckInitialState extends TicketonTicketCheckState {
  @override
  List<Object?> get props => [];
}

class TicketonTicketCheckLoadingState extends TicketonTicketCheckState {
  @override
  List<Object?> get props => [];
}

class TicketonTicketCheckFailedState extends TicketonTicketCheckState {
  final Failure failureData;
  TicketonTicketCheckFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class TicketonTicketCheckSuccessState extends TicketonTicketCheckState {
  final TicketonTicketCheckCommonResponseEntity ticketCheck;
  TicketonTicketCheckSuccessState(this.ticketCheck);
  @override
  List<Object?> get props => [ticketCheck];
}