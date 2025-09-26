import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/paginate_ticketon_order_parameter.dart';

@immutable
sealed class PaginateTicketOrderBaseEvent {}

class PaginateTicketOrderEvent extends PaginateTicketOrderBaseEvent {
  final PaginateTicketonOrderParameter parameter;
  PaginateTicketOrderEvent(this.parameter);
}

/// Событие для обновления (refresh) - очищает текущие данные и загружает заново
class RefreshTicketOrderEvent extends PaginateTicketOrderBaseEvent {
  final PaginateTicketonOrderParameter parameter;
  RefreshTicketOrderEvent(this.parameter);
}