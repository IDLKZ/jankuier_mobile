import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/paginate_yandex_afisha_parameter.dart';

@immutable
sealed class PaginateYandexAfishaTicketsBaseEvent {}

class PaginateYandexAfishaTicketsEvent extends PaginateYandexAfishaTicketsBaseEvent {
  final YandexAfishaWidgetTicketPaginationParameter parameter;
  PaginateYandexAfishaTicketsEvent(this.parameter);
}

/// Событие для обновления (refresh) - очищает текущие данные и загружает заново
class RefreshYandexAfishaTicketsEvent extends PaginateYandexAfishaTicketsBaseEvent {
  final YandexAfishaWidgetTicketPaginationParameter parameter;
  RefreshYandexAfishaTicketsEvent(this.parameter);
}
