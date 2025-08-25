import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';

@immutable
abstract class GetCountryStateState extends Equatable {}

class GetCountryStateInitialState extends GetCountryStateState {
  @override
  List<Object?> get props => [];
}

class GetCountryStateLoadingState extends GetCountryStateState {
  @override
  List<Object?> get props => [];
}

class GetCountryStateFailedState extends GetCountryStateState {
  final Failure failureData;
  GetCountryStateFailedState(this.failureData);
  @override
  List<Object?> get props => [failureData];
}

class GetCountryStateSuccessState extends GetCountryStateState {
  final SotaPaginationResponse<CountryEntity> countries;
  GetCountryStateSuccessState(this.countries);
  @override
  List<Object?> get props => [countries];
}
