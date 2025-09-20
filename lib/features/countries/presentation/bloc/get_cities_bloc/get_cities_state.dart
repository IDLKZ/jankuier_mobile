import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import '../../../../../core/common/entities/city_entity.dart';
import '../../../../../core/errors/failures.dart';

@immutable
abstract class GetCitiesState extends Equatable {}

class GetCitiesInitialState extends GetCitiesState {
  @override
  List<Object?> get props => [];
}

class GetCitiesLoadingState extends GetCitiesState {
  @override
  List<Object?> get props => [];
}

class GetCitiesFailedState extends GetCitiesState {
  final Failure failureData;
  GetCitiesFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class GetCitiesSuccessState extends GetCitiesState {
  final List<CityEntity> cities;
  GetCitiesSuccessState(this.cities);
  @override
  List<Object?> get props => [cities];
}