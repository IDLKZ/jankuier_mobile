import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';

@immutable
abstract class GetYandexAfishaTicketByIdState extends Equatable {}

class GetYandexAfishaTicketByIdInitialState extends GetYandexAfishaTicketByIdState {
  @override
  List<Object?> get props => [];
}

class GetYandexAfishaTicketByIdLoadingState extends GetYandexAfishaTicketByIdState {
  @override
  List<Object?> get props => [];
}

class GetYandexAfishaTicketByIdFailedState extends GetYandexAfishaTicketByIdState {
  final Failure failureData;
  GetYandexAfishaTicketByIdFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class GetYandexAfishaTicketByIdLoadedState extends GetYandexAfishaTicketByIdState {
  final YandexAfishaWidgetTicketEntity ticket;
  GetYandexAfishaTicketByIdLoadedState(this.ticket);
  @override
  List<Object?> get props => [ticket];
}
