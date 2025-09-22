import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_common_parameter.dart';

abstract class SeasonsEvent extends Equatable {
  const SeasonsEvent();

  @override
  List<Object?> get props => [];
}

class LoadSeasons extends SeasonsEvent {
  final KffLeagueCommonParameter parameter;

  const LoadSeasons(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class LoadSeasonById extends SeasonsEvent {
  final int seasonId;

  const LoadSeasonById(this.seasonId);

  @override
  List<Object?> get props => [seasonId];
}

class RefreshSeasons extends SeasonsEvent {
  final KffLeagueCommonParameter parameter;

  const RefreshSeasons(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class ResetSeasons extends SeasonsEvent {
  const ResetSeasons();
}