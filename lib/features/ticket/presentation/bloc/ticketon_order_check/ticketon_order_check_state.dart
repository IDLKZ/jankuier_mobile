import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/ticket_order/ticketon_order_check_entity.dart';

@immutable
abstract class TicketonOrderCheckState extends Equatable {}

class TicketonOrderCheckInitialState extends TicketonOrderCheckState {
  @override
  List<Object?> get props => [];
}

class TicketonOrderCheckLoadingState extends TicketonOrderCheckState {
  @override
  List<Object?> get props => [];
}

class TicketonOrderCheckFailedState extends TicketonOrderCheckState {
  final Failure failureData;
  TicketonOrderCheckFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class TicketonOrderCheckSuccessState extends TicketonOrderCheckState {
  final TicketonOrderCheckCommonResponseEntity orderCheck;
  TicketonOrderCheckSuccessState(this.orderCheck);
  @override
  List<Object?> get props => [orderCheck];
}