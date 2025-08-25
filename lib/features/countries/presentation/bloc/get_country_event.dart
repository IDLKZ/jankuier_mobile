import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';
import 'package:jankuier_mobile/features/countries/domain/interface/country_interface.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/parameters/get_country_parameter.dart';

@immutable
sealed class GetCountryBaseEvent {}

class GetCountryEvent extends GetCountryBaseEvent {
  final GetCountryParameter parameter;
  GetCountryEvent(this.parameter);
}
