import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/utils/http_utils.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_shows_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/ticketon_get_shows_parameter.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';

abstract class TicketonDSInterface {
  Future<TicketonShowsDataEntity> getShows(TicketonGetShowsParameter parameter);
}

@Injectable(as: TicketonDSInterface)
class TicketonDSImpl implements TicketonDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<TicketonShowsDataEntity> getShows(
      TicketonGetShowsParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.GetAllTicketonShowsUrl,
          queryParameters: parameter.toMap());
      final result = TicketonShowsDataEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
