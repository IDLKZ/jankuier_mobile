import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/constants/hive_constants.dart';
import 'package:jankuier_mobile/core/constants/sota_api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/sota_http_utils.dart';
import '../../domain/parameters/get_tournament_parameter.dart';
import '../entities/tournament_entity.dart';

abstract class TournamentDSInterface {
  Future<SotaPaginationResponse<TournamentEntity>> getCountriesFromSota(
      GetTournamentParameter parameter);
}

class TournamentDSImpl implements TournamentDSInterface {
  final httpUtils = SotaHttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<SotaPaginationResponse<TournamentEntity>> getCountriesFromSota(
      GetTournamentParameter parameter) async {
    try {
      DataMap query = parameter.toMap();
      int? selectedCountryId =
          await this.hiveUtils.get<int>(HiveConstant.mainCountryIdKey);
      if (selectedCountryId != null) {
        query["country"] = selectedCountryId.toString();
      }
      final response = await httpUtils.get(SotaApiConstant.GetTournamentURL,
          queryParameters: query);
      final result = SotaPaginationResponse<TournamentEntity>.fromJson(
          response, TournamentEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
