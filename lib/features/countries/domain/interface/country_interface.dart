import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';

import '../../../../core/common/entities/city_entity.dart';
import '../../../../core/utils/typedef.dart';
import '../parameters/get_city_parameter.dart';
import '../parameters/get_country_parameter.dart';

abstract class CountryInterface {
  ResultFuture<SotaPaginationResponse<CountryEntity>> getCountriesFromSota(
      GetCountryParameter parameter);

  ResultFuture<List<CityEntity>> getCities(CityFilterParameter parameter);
}
