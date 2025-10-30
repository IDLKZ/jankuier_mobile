import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/all_yandex_afisha_ticket_parameter.dart';

@immutable
sealed class GetAllYandexAfishaTicketsBaseEvent {}

class GetAllYandexAfishaTicketsEvent extends GetAllYandexAfishaTicketsBaseEvent {
  final AllYandexAfishaWidgetTicketFilterParameter parameter;
  GetAllYandexAfishaTicketsEvent(this.parameter);
}
