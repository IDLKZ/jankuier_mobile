import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_post_match_entity.dart';

@immutable
abstract class GetPastMatchesState extends Equatable {}

class GetPastMatchesInitialState extends GetPastMatchesState {
  @override
  List<Object?> get props => [];
}

class GetPastMatchesLoadingState extends GetPastMatchesState {
  @override
  List<Object?> get props => [];
}

class GetPastMatchesSuccessState extends GetPastMatchesState {
  final List<KffLeaguePostMatchEntity> matches;

  GetPastMatchesSuccessState(this.matches);

  @override
  List<Object?> get props => [matches];
}

class GetPastMatchesFailedState extends GetPastMatchesState {
  final Failure failure;

  GetPastMatchesFailedState(this.failure);

  @override
  List<Object?> get props => [failure];
}