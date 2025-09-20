import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';

@immutable
abstract class GetOneLeagueState extends Equatable {}

class GetOneLeagueInitialState extends GetOneLeagueState {
  @override
  List<Object?> get props => [];
}

class GetOneLeagueLoadingState extends GetOneLeagueState {
  @override
  List<Object?> get props => [];
}

class GetOneLeagueSuccessState extends GetOneLeagueState {
  final KffLeagueEntity league;

  GetOneLeagueSuccessState(this.league);

  @override
  List<Object?> get props => [league];
}

class GetOneLeagueFailedState extends GetOneLeagueState {
  final Failure failure;

  GetOneLeagueFailedState(this.failure);

  @override
  List<Object?> get props => [failure];
}