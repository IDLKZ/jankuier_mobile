import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/paginate_ticketon_order_parameter.dart';

@immutable
sealed class PaginateTicketOrderBaseEvent {}

class PaginateTicketOrderEvent extends PaginateTicketOrderBaseEvent {
  final PaginateTicketonOrderParameter parameter;
  PaginateTicketOrderEvent(this.parameter);
}