import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class GetFieldDetailEvent extends Equatable {}

class GetFieldEvent extends GetFieldDetailEvent {
  final int fieldId;
  GetFieldEvent(this.fieldId);
  @override
  List<Object?> get props => [fieldId];
}