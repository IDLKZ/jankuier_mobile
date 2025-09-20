import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetFutureMatchesEvent extends Equatable {}

class GetFutureMatchesRequestEvent extends GetFutureMatchesEvent {
  final int leagueId;

  GetFutureMatchesRequestEvent(this.leagueId);

  @override
  List<Object?> get props => [leagueId];
}