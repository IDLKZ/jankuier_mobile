import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/academy_group_schedule_entity.dart';

@immutable
abstract class AcademyGroupScheduleState extends Equatable {}

class AcademyGroupScheduleInitialState extends AcademyGroupScheduleState {
  @override
  List<Object?> get props => [];
}

class AcademyGroupScheduleLoadingState extends AcademyGroupScheduleState {
  @override
  List<Object?> get props => [];
}

class AcademyGroupScheduleFailedState extends AcademyGroupScheduleState {
  final Failure failure;
  AcademyGroupScheduleFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class AcademyGroupScheduleLoadedState extends AcademyGroupScheduleState {
  final List<AcademyGroupScheduleEntity> schedules;
  AcademyGroupScheduleLoadedState(this.schedules);
  @override
  List<Object?> get props => [schedules];
}