import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_season_entity.dart';

abstract class SeasonsState extends Equatable {
  const SeasonsState();

  @override
  List<Object?> get props => [];
}

class SeasonsInitial extends SeasonsState {
  const SeasonsInitial();
}

class SeasonsLoading extends SeasonsState {
  const SeasonsLoading();
}

class SeasonsLoaded extends SeasonsState {
  final KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity> seasons;

  const SeasonsLoaded(this.seasons);

  @override
  List<Object?> get props => [seasons];
}

class SingleSeasonLoaded extends SeasonsState {
  final KffLeagueSingleResponseEntity<KffLeagueSeasonEntity> season;

  const SingleSeasonLoaded(this.season);

  @override
  List<Object?> get props => [season];
}

class SeasonsError extends SeasonsState {
  final String message;

  const SeasonsError(this.message);

  @override
  List<Object?> get props => [message];
}