import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';

@immutable
abstract class GetAllYandexAfishaTicketsState extends Equatable {}

class GetAllYandexAfishaTicketsInitialState extends GetAllYandexAfishaTicketsState {
  @override
  List<Object?> get props => [];
}

class GetAllYandexAfishaTicketsLoadingState extends GetAllYandexAfishaTicketsState {
  @override
  List<Object?> get props => [];
}

class GetAllYandexAfishaTicketsFailedState extends GetAllYandexAfishaTicketsState {
  final Failure failureData;
  GetAllYandexAfishaTicketsFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class GetAllYandexAfishaTicketsLoadedState extends GetAllYandexAfishaTicketsState {
  final List<YandexAfishaWidgetTicketEntity> tickets;
  GetAllYandexAfishaTicketsLoadedState(this.tickets);
  @override
  List<Object?> get props => [tickets];
}
