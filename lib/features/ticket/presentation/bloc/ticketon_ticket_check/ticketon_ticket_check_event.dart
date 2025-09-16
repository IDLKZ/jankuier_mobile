import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/ticketon_ticket_check_parameter.dart';

@immutable
sealed class TicketonTicketCheckBaseEvent {}

class TicketonTicketCheckEvent extends TicketonTicketCheckBaseEvent {
  final TicketonTicketCheckParameter parameter;
  TicketonTicketCheckEvent(this.parameter);
}