import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_coach_entity.dart';

@immutable
abstract class GetCoachesState extends Equatable {}

class GetCoachesInitialState extends GetCoachesState {
  @override
  List<Object?> get props => [];
}

class GetCoachesLoadingState extends GetCoachesState {
  @override
  List<Object?> get props => [];
}

class GetCoachesSuccessState extends GetCoachesState {
  final List<KffCoachImageEntity> coaches;

  GetCoachesSuccessState(this.coaches);

  @override
  List<Object?> get props => [coaches];
}

class GetCoachesFailedState extends GetCoachesState {
  final Failure failure;

  GetCoachesFailedState(this.failure);

  @override
  List<Object?> get props => [failure];
}