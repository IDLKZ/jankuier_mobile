import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';

@immutable
abstract class FieldPartyState extends Equatable {}

class FieldPartyInitialState extends FieldPartyState {
  @override
  List<Object?> get props => [];
}

class PaginateFieldPartyLoadingState extends FieldPartyState {
  @override
  List<Object?> get props => [];
}

class PaginateFieldPartyFailedState extends FieldPartyState {
  final Failure failure;
  PaginateFieldPartyFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class PaginateFieldPartyLoadedState extends FieldPartyState {
  final Pagination<FieldPartyEntity> pagination;
  final List<FieldPartyEntity> fieldParties;
  PaginateFieldPartyLoadedState(
    this.pagination,
    this.fieldParties,
  );
  @override
  List<Object?> get props => [fieldParties];
}