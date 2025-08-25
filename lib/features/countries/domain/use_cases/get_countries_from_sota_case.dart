import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../interface/country_interface.dart';
import '../parameters/get_country_parameter.dart';

class GetCountriesFromSotaCase extends UseCaseWithParams<
    SotaPaginationResponse<CountryEntity>, GetCountryParameter> {
  final CountryInterface _countryInterface;
  const GetCountriesFromSotaCase(this._countryInterface);

  @override
  ResultFuture<SotaPaginationResponse<CountryEntity>> call(
      GetCountryParameter params) {
    return _countryInterface.getCountriesFromSota(params);
  }
}
