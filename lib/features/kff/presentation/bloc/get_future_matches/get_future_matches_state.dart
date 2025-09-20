import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_match_entity.dart';

@immutable
abstract class GetFutureMatchesState extends Equatable {}

class GetFutureMatchesInitialState extends GetFutureMatchesState {
  @override
  List<Object?> get props => [];
}

class GetFutureMatchesLoadingState extends GetFutureMatchesState {
  @override
  List<Object?> get props => [];
}

class GetFutureMatchesSuccessState extends GetFutureMatchesState {
  final List<KffLeagueMatchEntity> matches;

  GetFutureMatchesSuccessState(this.matches);

  @override
  List<Object?> get props => [matches];
}

class GetFutureMatchesFailedState extends GetFutureMatchesState {
  final Failure failure;

  GetFutureMatchesFailedState(this.failure);

  @override
  List<Object?> get props => [failure];
}