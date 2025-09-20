import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/constants/sota_api_constants.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';

import '../../../../core/common/entities/city_entity.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../../../core/utils/sota_http_utils.dart';
import '../../domain/parameters/get_city_parameter.dart';
import '../../domain/parameters/get_country_parameter.dart';

abstract class CountryDSInterface {
  Future<SotaPaginationResponse<CountryEntity>> getCountriesFromSota(
      GetCountryParameter parameter);
  Future<List<CityEntity>> getCities(CityFilterParameter parameter);
}

class CountryDSImpl implements CountryDSInterface {
  final sotaHttpUtils = SotaHttpUtil();
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<SotaPaginationResponse<CountryEntity>> getCountriesFromSota(
      GetCountryParameter parameter) async {
    try {
      final response = await sotaHttpUtils.get(SotaApiConstant.GetCountryURL,
          queryParameters: parameter.toMap());
      final result = SotaPaginationResponse<CountryEntity>.fromJson(
          response, CountryEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<CityEntity>> getCities(CityFilterParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.GetAllCitiesUrl,
          queryParameters: parameter.toQueryParameters());
      final result = CityListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
