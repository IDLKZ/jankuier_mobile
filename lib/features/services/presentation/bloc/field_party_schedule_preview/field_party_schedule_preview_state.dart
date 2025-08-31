import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_schedule_record_entity.dart';

@immutable
abstract class FieldPartySchedulePreviewState extends Equatable {}

class FieldPartySchedulePreviewInitialState extends FieldPartySchedulePreviewState {
  @override
  List<Object?> get props => [];
}

class FieldPartySchedulePreviewLoadingState extends FieldPartySchedulePreviewState {
  @override
  List<Object?> get props => [];
}

class FieldPartySchedulePreviewFailedState extends FieldPartySchedulePreviewState {
  final Failure failure;
  FieldPartySchedulePreviewFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class FieldPartySchedulePreviewLoadedState extends FieldPartySchedulePreviewState {
  final ScheduleGeneratorResponseEntity schedulePreview;
  FieldPartySchedulePreviewLoadedState(this.schedulePreview);
  @override
  List<Object?> get props => [schedulePreview];
}