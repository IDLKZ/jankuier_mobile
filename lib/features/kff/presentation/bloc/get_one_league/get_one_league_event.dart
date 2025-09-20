import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetOneLeagueEvent extends Equatable {}

class GetOneLeagueRequestEvent extends GetOneLeagueEvent {
  final int leagueId;

  GetOneLeagueRequestEvent(this.leagueId);

  @override
  List<Object?> get props => [leagueId];
}