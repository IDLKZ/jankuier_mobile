import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_field_party_parameter.dart';

@immutable
sealed class AllFieldPartyEvent extends Equatable {}

class GetAllFieldPartyEvent extends AllFieldPartyEvent {
  final AllFieldPartyParameter parameter;
  GetAllFieldPartyEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}