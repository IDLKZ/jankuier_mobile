import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';

@immutable
abstract class AllFieldPartyState extends Equatable {}

class AllFieldPartyInitialState extends AllFieldPartyState {
  @override
  List<Object?> get props => [];
}

class AllFieldPartyLoadingState extends AllFieldPartyState {
  @override
  List<Object?> get props => [];
}

class AllFieldPartyFailedState extends AllFieldPartyState {
  final Failure failure;
  AllFieldPartyFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class AllFieldPartyLoadedState extends AllFieldPartyState {
  final List<FieldPartyEntity> fieldParties;
  AllFieldPartyLoadedState(this.fieldParties);
  @override
  List<Object?> get props => [fieldParties];
}