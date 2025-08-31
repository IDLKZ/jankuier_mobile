import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_party_parameter.dart';

@immutable
sealed class FieldPartyEvent extends Equatable {}

class PaginateFieldPartyEvent extends FieldPartyEvent {
  final PaginateFieldPartyParameter parameter;
  PaginateFieldPartyEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}