import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_player_entity.dart';

@immutable
abstract class GetPlayersState extends Equatable {}

class GetPlayersInitialState extends GetPlayersState {
  @override
  List<Object?> get props => [];
}

class GetPlayersLoadingState extends GetPlayersState {
  @override
  List<Object?> get props => [];
}

class GetPlayersSuccessState extends GetPlayersState {
  final List<KffLeaguePlayerEntity> players;

  GetPlayersSuccessState(this.players);

  @override
  List<Object?> get props => [players];
}

class GetPlayersFailedState extends GetPlayersState {
  final Failure failure;

  GetPlayersFailedState(this.failure);

  @override
  List<Object?> get props => [failure];
}