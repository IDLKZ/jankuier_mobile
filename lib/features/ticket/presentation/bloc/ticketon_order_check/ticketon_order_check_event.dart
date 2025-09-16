import 'package:flutter/cupertino.dart';

@immutable
sealed class TicketonOrderCheckBaseEvent {}

class TicketonOrderCheckEvent extends TicketonOrderCheckBaseEvent {
  final int ticketOrderId;
  TicketonOrderCheckEvent(this.ticketOrderId);
}