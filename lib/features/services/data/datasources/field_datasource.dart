import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_entity.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_schedule_record_entity.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_field_parameter.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../domain/parameters/all_field_gallery_parameter.dart';
import '../../domain/parameters/all_field_parameter.dart';
import '../../domain/parameters/all_field_party_parameter.dart';
import '../../domain/parameters/field_party_schedule_preview_parameter.dart';
import '../../domain/parameters/paginate_field_party_parameter.dart';
import '../entities/field/field_gallery_entity.dart';
import '../entities/field/field_party_entity.dart';

abstract class FieldDSInterface {
  //Field
  Future<Pagination<FieldEntity>> paginateField(
      PaginateFieldParameter parameter);

  Future<List<FieldEntity>> allField(AllFieldParameter parameter);

  Future<FieldEntity> getField(int fieldId);

  //Field Party
  Future<Pagination<FieldPartyEntity>> paginateFieldParty(
      PaginateFieldPartyParameter parameter);

  Future<List<FieldPartyEntity>> allFieldParty(
      AllFieldPartyParameter parameter);

  Future<FieldPartyEntity> getFieldParty(int fieldPartyId);

  //Field Gallery
  Future<List<FieldGalleryEntity>> allFieldGallery(
      AllFieldGalleryFilter parameter);

  //Get Field Shedule Preview
  Future<ScheduleGeneratorResponseEntity> getFieldPartySchedulePreview(
      FieldPartySchedulePreviewParameter parameter);
}

class FieldDSImpl implements FieldDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<List<FieldGalleryEntity>> allFieldGallery(
      AllFieldGalleryFilter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.AllFieldGalleryUrl,
          queryParameters: parameter.toQueryParameters());
      final result = FieldGalleryListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<FieldPartyEntity>> allFieldParty(
      AllFieldPartyParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.AllFieldPartiesUrl,
          queryParameters: parameter.toQueryParameters());
      final result = FieldPartyListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<List<FieldEntity>> allField(AllFieldParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.AllFieldsUrl,
          queryParameters: parameter.toQueryParameters());
      final result = FieldListEntity.fromJsonList(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<FieldEntity> getField(int fieldId) async {
    try {
      final response =
          await httpUtils.get(ApiConstant.GetFieldByIdUrl(fieldId));
      final result = FieldEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<FieldPartyEntity> getFieldParty(int fieldPartyId) async {
    try {
      final response =
          await httpUtils.get(ApiConstant.GetFieldPartyByIdUrl(fieldPartyId));
      final result = FieldPartyEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<ScheduleGeneratorResponseEntity> getFieldPartySchedulePreview(
      FieldPartySchedulePreviewParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.GetFieldPartyGeneratedSchdedulePreviewUrl,
          queryParameters: parameter.toQueryParameters());
      final result = ScheduleGeneratorResponseEntity.fromJson(response);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<FieldEntity>> paginateField(
      PaginateFieldParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.PaginateFieldsUrl,
          queryParameters: parameter.toQueryParameters());
      final result =
          Pagination<FieldEntity>.fromJson(response, FieldEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<FieldPartyEntity>> paginateFieldParty(
      PaginateFieldPartyParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.PaginateFieldPartiesUrl,
          queryParameters: parameter.toQueryParameters());
      final result = Pagination<FieldPartyEntity>.fromJson(
          response, FieldPartyEntity.fromJson);
      return result;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }
}
