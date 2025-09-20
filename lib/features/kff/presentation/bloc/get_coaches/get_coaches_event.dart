import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetCoachesEvent extends Equatable {}

class GetCoachesRequestEvent extends GetCoachesEvent {
  final int leagueId;

  GetCoachesRequestEvent(this.leagueId);

  @override
  List<Object?> get props => [leagueId];
}