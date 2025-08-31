import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';

@immutable
abstract class GetFieldPartyDetailState extends Equatable {}

class GetFieldPartyDetailInitialState extends GetFieldPartyDetailState {
  @override
  List<Object?> get props => [];
}

class GetFieldPartyDetailLoadingState extends GetFieldPartyDetailState {
  @override
  List<Object?> get props => [];
}

class GetFieldPartyDetailFailedState extends GetFieldPartyDetailState {
  final Failure failure;
  GetFieldPartyDetailFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class GetFieldPartyDetailLoadedState extends GetFieldPartyDetailState {
  final FieldPartyEntity fieldParty;
  GetFieldPartyDetailLoadedState(this.fieldParty);
  @override
  List<Object?> get props => [fieldParty];
}