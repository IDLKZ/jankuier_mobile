import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/field_party_schedule_preview_parameter.dart';

@immutable
sealed class FieldPartySchedulePreviewEvent extends Equatable {}

class GetFieldPartySchedulePreviewEvent extends FieldPartySchedulePreviewEvent {
  final FieldPartySchedulePreviewParameter parameter;
  GetFieldPartySchedulePreviewEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}