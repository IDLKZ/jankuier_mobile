import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetPastMatchesEvent extends Equatable {}

class GetPastMatchesRequestEvent extends GetPastMatchesEvent {
  final int leagueId;

  GetPastMatchesRequestEvent(this.leagueId);

  @override
  List<Object?> get props => [leagueId];
}