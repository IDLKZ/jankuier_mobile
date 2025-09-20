import '../../../../core/common/entities/city_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../interface/country_interface.dart';
import '../parameters/get_city_parameter.dart';

class GetCitiesCase extends UseCaseWithParams<List<CityEntity>, CityFilterParameter> {
  final CountryInterface _countryInterface;
  const GetCitiesCase(this._countryInterface);

  @override
  ResultFuture<List<CityEntity>> call(CityFilterParameter params) {
    return _countryInterface.getCities(params);
  }
}