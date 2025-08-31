import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_entity.dart';

@immutable
abstract class AllFieldState extends Equatable {}

class AllFieldInitialState extends AllFieldState {
  @override
  List<Object?> get props => [];
}

class AllFieldLoadingState extends AllFieldState {
  @override
  List<Object?> get props => [];
}

class AllFieldFailedState extends AllFieldState {
  final Failure failure;
  AllFieldFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class AllFieldLoadedState extends AllFieldState {
  final List<FieldEntity> fields;
  AllFieldLoadedState(this.fields);
  @override
  List<Object?> get props => [fields];
}