import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_academy_parameter.dart';

@immutable
sealed class AcademyEvent extends Equatable {}

class PaginateAcademyEvent extends AcademyEvent {
  final PaginateAcademyParameter parameter;
  PaginateAcademyEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}