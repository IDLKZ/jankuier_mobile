import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_parameter.dart';

@immutable
sealed class FieldEvent extends Equatable {}

class PaginateFieldEvent extends FieldEvent {
  final PaginateFieldParameter parameter;
  PaginateFieldEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}