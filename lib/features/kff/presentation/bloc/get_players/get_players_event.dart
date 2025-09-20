import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetPlayersEvent extends Equatable {}

class GetPlayersRequestEvent extends GetPlayersEvent {
  final int leagueId;

  GetPlayersRequestEvent(this.leagueId);

  @override
  List<Object?> get props => [leagueId];
}