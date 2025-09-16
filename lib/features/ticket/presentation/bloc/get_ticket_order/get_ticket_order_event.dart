import 'package:flutter/cupertino.dart';

@immutable
sealed class GetTicketOrderBaseEvent {}

class GetTicketOrderEvent extends GetTicketOrderBaseEvent {
  final int ticketOrderId;
  GetTicketOrderEvent(this.ticketOrderId);
}