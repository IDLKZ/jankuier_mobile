import 'package:equatable/equatable.dart';

abstract class TournamentsEvent extends Equatable {
  const TournamentsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTournaments extends TournamentsEvent {
  const LoadTournaments();
}

class LoadTournamentById extends TournamentsEvent {
  final int tournamentId;

  const LoadTournamentById(this.tournamentId);

  @override
  List<Object?> get props => [tournamentId];
}

class RefreshTournaments extends TournamentsEvent {
  const RefreshTournaments();
}

class ResetTournaments extends TournamentsEvent {
  const ResetTournaments();
}