import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/academy_group_schedule_by_day_parameter.dart';

@immutable
sealed class AcademyGroupScheduleEvent extends Equatable {}

class GetAcademyGroupScheduleEvent extends AcademyGroupScheduleEvent {
  final AcademyGroupScheduleByDayParameter parameter;
  GetAcademyGroupScheduleEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}