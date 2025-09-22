import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_championship_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';

abstract class ChampionshipsState extends Equatable {
  const ChampionshipsState();

  @override
  List<Object?> get props => [];
}

class ChampionshipsInitial extends ChampionshipsState {
  const ChampionshipsInitial();
}

class ChampionshipsLoading extends ChampionshipsState {
  const ChampionshipsLoading();
}

class ChampionshipsLoaded extends ChampionshipsState {
  final KffLeaguePaginatedResponseEntity<KffLeagueChampionshipEntity> championships;

  const ChampionshipsLoaded(this.championships);

  @override
  List<Object?> get props => [championships];
}

class SingleChampionshipLoaded extends ChampionshipsState {
  final KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity> championship;

  const SingleChampionshipLoaded(this.championship);

  @override
  List<Object?> get props => [championship];
}

class ChampionshipsError extends ChampionshipsState {
  final String message;

  const ChampionshipsError(this.message);

  @override
  List<Object?> get props => [message];
}