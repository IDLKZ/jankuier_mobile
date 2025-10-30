import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';

@immutable
abstract class PaginateYandexAfishaTicketsState extends Equatable {}

class PaginateYandexAfishaTicketsInitialState extends PaginateYandexAfishaTicketsState {
  @override
  List<Object?> get props => [];
}

class PaginateYandexAfishaTicketsLoadingState extends PaginateYandexAfishaTicketsState {
  @override
  List<Object?> get props => [];
}

class PaginateYandexAfishaTicketsFailedState extends PaginateYandexAfishaTicketsState {
  final Failure failureData;
  PaginateYandexAfishaTicketsFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class PaginateYandexAfishaTicketsLoadedState extends PaginateYandexAfishaTicketsState {
  final Pagination<YandexAfishaWidgetTicketEntity> paginationData;
  final List<YandexAfishaWidgetTicketEntity> tickets;
  PaginateYandexAfishaTicketsLoadedState(this.paginationData, this.tickets);
  @override
  List<Object?> get props => [paginationData, tickets];
}
