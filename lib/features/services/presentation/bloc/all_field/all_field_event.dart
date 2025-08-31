import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_field_parameter.dart';

@immutable
sealed class AllFieldEvent extends Equatable {}

class GetAllFieldEvent extends AllFieldEvent {
  final AllFieldParameter parameter;
  GetAllFieldEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}