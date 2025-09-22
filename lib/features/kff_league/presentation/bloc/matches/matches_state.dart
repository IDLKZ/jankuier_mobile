import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';

abstract class MatchesState extends Equatable {
  const MatchesState();

  @override
  List<Object?> get props => [];
}

class MatchesInitial extends MatchesState {
  const MatchesInitial();
}

class MatchesLoading extends MatchesState {
  const MatchesLoading();
}

class MatchesLoaded extends MatchesState {
  final KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity> matches;

  const MatchesLoaded(this.matches);

  @override
  List<Object?> get props => [matches];
}

class SingleMatchLoaded extends MatchesState {
  final KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity> match;

  const SingleMatchLoaded(this.match);

  @override
  List<Object?> get props => [match];
}

class MatchesLoadingMore extends MatchesState {
  final KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity> currentMatches;

  const MatchesLoadingMore(this.currentMatches);

  @override
  List<Object?> get props => [currentMatches];
}

class MatchesError extends MatchesState {
  final String message;

  const MatchesError(this.message);

  @override
  List<Object?> get props => [message];
}