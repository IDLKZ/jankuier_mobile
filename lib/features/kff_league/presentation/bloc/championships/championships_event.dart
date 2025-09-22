import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_common_parameter.dart';

abstract class ChampionshipsEvent extends Equatable {
  const ChampionshipsEvent();

  @override
  List<Object?> get props => [];
}

class LoadChampionships extends ChampionshipsEvent {
  final KffLeagueCommonParameter parameter;

  const LoadChampionships(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class LoadChampionshipById extends ChampionshipsEvent {
  final int championshipId;

  const LoadChampionshipById(this.championshipId);

  @override
  List<Object?> get props => [championshipId];
}

class RefreshChampionships extends ChampionshipsEvent {
  final KffLeagueCommonParameter parameter;

  const RefreshChampionships(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class ResetChampionships extends ChampionshipsEvent {
  const ResetChampionships();
}