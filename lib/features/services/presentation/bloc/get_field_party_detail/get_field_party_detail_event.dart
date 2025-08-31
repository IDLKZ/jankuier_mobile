import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class GetFieldPartyDetailEvent extends Equatable {}

class GetFieldPartyEvent extends GetFieldPartyDetailEvent {
  final int fieldPartyId;
  GetFieldPartyEvent(this.fieldPartyId);
  @override
  List<Object?> get props => [fieldPartyId];
}