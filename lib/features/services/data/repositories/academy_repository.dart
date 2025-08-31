import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/academy_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/academy_group_schedule_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/get_full_academy_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/academy_group_schedule_by_day_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_academy_parameter.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/interface/academy_interface.dart';
import '../datasources/academy_datasource.dart';

class AcademyRepository implements AcademyInterface {
  final AcademyDSInterface academyDSInterface;

  const AcademyRepository(this.academyDSInterface);

  @override
  ResultFuture<Pagination<AcademyEntity>> paginateAcademy(
      PaginateAcademyParameter parameter) async {
    try {
      final result = await academyDSInterface.paginateAcademy(parameter);
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
  ResultFuture<GetFullAcademyEntity> getFullAcademyDetailById(int academyId) async {
    try {
      final result = await academyDSInterface.getFullAcademyDetailById(academyId);
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
  ResultFuture<List<AcademyGroupScheduleEntity>> getAcademyGroupScheduleByDayAndGroups(
      AcademyGroupScheduleByDayParameter parameter) async {
    try {
      final result = await academyDSInterface.getAcademyGroupScheduleByDayAndGroups(parameter);
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