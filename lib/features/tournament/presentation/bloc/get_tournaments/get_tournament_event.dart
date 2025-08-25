import 'package:flutter/cupertino.dart';

import '../../../domain/parameters/get_tournament_parameter.dart';

@immutable
sealed class GetTournamentBaseEvent {}

class GetTournamentEvent extends GetTournamentBaseEvent {
  final GetTournamentParameter parameter;
  GetTournamentEvent(this.parameter);
}
