import 'package:dio/dio.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/academy_group_schedule_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/academy_group_schedule_by_day_parameter.dart';
import '../../../../core/common/entities/pagination_entity.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../domain/parameters/paginate_academy_parameter.dart';
import '../entities/academy/academy_entity.dart';
import '../entities/academy/get_full_academy_entity.dart';

abstract class AcademyDSInterface {
  Future<Pagination<AcademyEntity>> paginateAcademy(
      PaginateAcademyParameter parameter);
  Future<GetFullAcademyEntity> getFullAcademyDetailById(int academyId);
  Future<List<AcademyGroupScheduleEntity>>
      getAcademyGroupScheduleByDayAndGroups(
          AcademyGroupScheduleByDayParameter parameter);
}

class AcademyDSImpl implements AcademyDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<List<AcademyGroupScheduleEntity>>
      getAcademyGroupScheduleByDayAndGroups(
          AcademyGroupScheduleByDayParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.GetAcademyGroupScheduleByDayAndGroupsIdUrl,
          queryParameters: parameter.toQueryParameters());
      final result = AcademyGroupScheduleListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<GetFullAcademyEntity> getFullAcademyDetailById(int academyId) async {
    try {
      final response = await httpUtils
          .get(ApiConstant.GetFullAcademyDetailByIdUrl(academyId));
      final result = GetFullAcademyEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<AcademyEntity>> paginateAcademy(
      PaginateAcademyParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.PaginateAcademyUrl,
          queryParameters: parameter.toQueryParameters());
      final result =
          Pagination<AcademyEntity>.fromJson(response, AcademyEntity.fromJson);
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
