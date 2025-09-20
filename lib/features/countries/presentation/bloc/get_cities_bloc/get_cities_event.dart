import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/get_city_parameter.dart';

@immutable
sealed class GetCitiesBaseEvent {}

class GetCitiesEvent extends GetCitiesBaseEvent {
  final CityFilterParameter parameter;
  GetCitiesEvent(this.parameter);
}