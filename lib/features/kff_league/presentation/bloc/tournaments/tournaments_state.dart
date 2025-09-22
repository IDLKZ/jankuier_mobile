import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_tournament_entity.dart';

abstract class TournamentsState extends Equatable {
  const TournamentsState();

  @override
  List<Object?> get props => [];
}

class TournamentsInitial extends TournamentsState {
  const TournamentsInitial();
}

class TournamentsLoading extends TournamentsState {
  const TournamentsLoading();
}

class TournamentsLoaded extends TournamentsState {
  final KffLeagueTournamentWithSeasonsResponseEntity tournaments;

  const TournamentsLoaded(this.tournaments);

  @override
  List<Object?> get props => [tournaments];
}

class SingleTournamentLoaded extends TournamentsState {
  final KffLeagueTournamentWithSeasonsSingleResponseEntity tournament;

  const SingleTournamentLoaded(this.tournament);

  @override
  List<Object?> get props => [tournament];
}

class TournamentsError extends TournamentsState {
  final String message;

  const TournamentsError(this.message);

  @override
  List<Object?> get props => [message];
}