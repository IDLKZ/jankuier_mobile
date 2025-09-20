import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';
import '../../../../core/common/entities/city_entity.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/interface/country_interface.dart';
import '../../domain/parameters/get_city_parameter.dart';
import '../../domain/parameters/get_country_parameter.dart';
import '../datasources/country_datasource.dart';

class CountryRepository implements CountryInterface {
  final CountryDSInterface countryDSInterface;

  const CountryRepository(this.countryDSInterface);

  @override
  ResultFuture<SotaPaginationResponse<CountryEntity>> getCountriesFromSota(
      GetCountryParameter parameter) async {
    try {
      final result =
          await this.countryDSInterface.getCountriesFromSota(parameter);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<List<CityEntity>> getCities(CityFilterParameter parameter) async {
    try {
      final result = await this.countryDSInterface.getCities(parameter);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }
}
