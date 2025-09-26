import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_match_parameter.dart';

abstract class MatchesEvent extends Equatable {
  const MatchesEvent();

  @override
  List<Object?> get props => [];
}

class LoadMatches extends MatchesEvent {
  final KffLeagueClubMatchParameters parameter;

  const LoadMatches(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class LoadMatchById extends MatchesEvent {
  final int matchId;

  const LoadMatchById(this.matchId);

  @override
  List<Object?> get props => [matchId];
}

class RefreshMatches extends MatchesEvent {
  final KffLeagueClubMatchParameters parameter;

  const RefreshMatches(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class ResetMatches extends MatchesEvent {
  const ResetMatches();
}

class LoadMoreMatches extends MatchesEvent {
  final KffLeagueClubMatchParameters parameter;

  const LoadMoreMatches(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

/// Обновить матчи при смене языка
class RefreshMatchesContentEvent extends MatchesEvent {
  final KffLeagueClubMatchParameters parameter;

  const RefreshMatchesContentEvent(this.parameter);

  @override
  List<Object?> get props => [parameter];
}