import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_gallery_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_party_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_schedule_record_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_field_gallery_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_field_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_field_party_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/field_party_schedule_preview_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_party_parameter.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/interface/field_interface.dart';
import '../datasources/field_datasource.dart';

class FieldRepository implements FieldInterface {
  final FieldDSInterface fieldDSInterface;

  const FieldRepository(this.fieldDSInterface);

  @override
  ResultFuture<Pagination<FieldEntity>> paginateField(
      PaginateFieldParameter parameter) async {
    try {
      final result = await fieldDSInterface.paginateField(parameter);
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
  ResultFuture<List<FieldEntity>> allField(AllFieldParameter parameter) async {
    try {
      final result = await fieldDSInterface.allField(parameter);
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
  ResultFuture<FieldEntity> getField(int fieldId) async {
    try {
      final result = await fieldDSInterface.getField(fieldId);
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
  ResultFuture<Pagination<FieldPartyEntity>> paginateFieldParty(
      PaginateFieldPartyParameter parameter) async {
    try {
      final result = await fieldDSInterface.paginateFieldParty(parameter);
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
  ResultFuture<List<FieldPartyEntity>> allFieldParty(
      AllFieldPartyParameter parameter) async {
    try {
      final result = await fieldDSInterface.allFieldParty(parameter);
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
  ResultFuture<FieldPartyEntity> getFieldParty(int fieldPartyId) async {
    try {
      final result = await fieldDSInterface.getFieldParty(fieldPartyId);
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
  ResultFuture<List<FieldGalleryEntity>> allFieldGallery(
      AllFieldGalleryFilter parameter) async {
    try {
      final result = await fieldDSInterface.allFieldGallery(parameter);
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
  ResultFuture<ScheduleGeneratorResponseEntity> getFieldPartySchedulePreview(
      FieldPartySchedulePreviewParameter parameter) async {
    try {
      final result =
          await fieldDSInterface.getFieldPartySchedulePreview(parameter);
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