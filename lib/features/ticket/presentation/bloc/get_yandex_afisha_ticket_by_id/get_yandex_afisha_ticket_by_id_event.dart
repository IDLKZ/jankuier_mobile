import 'package:flutter/cupertino.dart';

@immutable
sealed class GetYandexAfishaTicketByIdBaseEvent {}

class GetYandexAfishaTicketByIdEvent extends GetYandexAfishaTicketByIdBaseEvent {
  final int yandexAfishaId;
  GetYandexAfishaTicketByIdEvent(this.yandexAfishaId);
}
