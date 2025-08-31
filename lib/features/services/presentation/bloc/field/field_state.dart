import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_entity.dart';

@immutable
abstract class FieldState extends Equatable {}

class FieldInitialState extends FieldState {
  @override
  List<Object?> get props => [];
}

class PaginateFieldLoadingState extends FieldState {
  @override
  List<Object?> get props => [];
}

class PaginateFieldFailedState extends FieldState {
  final Failure failure;
  PaginateFieldFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class PaginateFieldLoadedState extends FieldState {
  final Pagination<FieldEntity> pagination;
  final List<FieldEntity> fields;
  PaginateFieldLoadedState(
    this.pagination,
    this.fields,
  );
  @override
  List<Object?> get props => [fields];
}