import 'package:equatable/equatable.dart';

import '../../domain/parameters/match_parameter.dart';

abstract class StandingEvent extends Equatable {
  const StandingEvent();

  @override
  List<Object?> get props => [];
}

class LoadStandingsTableFromSotaEvent extends StandingEvent {}

class LoadMatchesFromSotaEvent extends StandingEvent {
  final MatchParameter parameter;

  const LoadMatchesFromSotaEvent(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

/// Обновить данные турнирной таблицы и матчей при смене языка
class RefreshStandingsContentEvent extends StandingEvent {
  const RefreshStandingsContentEvent();
}
