import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/tournament_entity.dart';

@immutable
abstract class GetTournamentStateState extends Equatable {}

class GetTournamentStateInitialState extends GetTournamentStateState {
  @override
  List<Object?> get props => [];
}

class GetTournamentStateLoadingState extends GetTournamentStateState {
  @override
  List<Object?> get props => [];
}

class GetTournamentStateFailedState extends GetTournamentStateState {
  final Failure failureData;
  GetTournamentStateFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class GetTournamentStateSuccessState extends GetTournamentStateState {
  final SotaPaginationResponse<TournamentEntity> tournaments;
  GetTournamentStateSuccessState(this.tournaments);
  @override
  List<Object?> get props => [tournaments];
}
