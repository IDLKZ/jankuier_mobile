import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_entity.dart';

@immutable
abstract class GetFieldDetailState extends Equatable {}

class GetFieldDetailInitialState extends GetFieldDetailState {
  @override
  List<Object?> get props => [];
}

class GetFieldDetailLoadingState extends GetFieldDetailState {
  @override
  List<Object?> get props => [];
}

class GetFieldDetailFailedState extends GetFieldDetailState {
  final Failure failure;
  GetFieldDetailFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class GetFieldDetailLoadedState extends GetFieldDetailState {
  final FieldEntity field;
  GetFieldDetailLoadedState(this.field);
  @override
  List<Object?> get props => [field];
}