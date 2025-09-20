import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';

@immutable
abstract class GetAllLeagueState extends Equatable {}

class GetAllLeagueInitialState extends GetAllLeagueState {
  @override
  List<Object?> get props => [];
}

class GetAllLeagueLoadingState extends GetAllLeagueState {
  @override
  List<Object?> get props => [];
}

class GetAllLeagueSuccessState extends GetAllLeagueState {
  final List<KffLeagueEntity> leagues;

  GetAllLeagueSuccessState(this.leagues);

  @override
  List<Object?> get props => [leagues];
}

class GetAllLeagueFailedState extends GetAllLeagueState {
  final Failure failure;

  GetAllLeagueFailedState(this.failure);

  @override
  List<Object?> get props => [failure];
}