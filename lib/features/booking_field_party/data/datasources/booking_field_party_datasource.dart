import 'package:dio/dio.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/features/booking_field_party/data/entities/booking_field_party_request_entity.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../../../../core/utils/http_utils.dart';
import '../../domain/parameters/booking_field_party_request_pagination_parameter.dart';
import '../../domain/parameters/create_booking_field_party_request_parameter.dart';
import '../entities/create_booking_field_party_response_entity.dart';

abstract class BookingFieldPartyDSInterface {
  Future<CreateBookingFieldPartyResponseEntity> createBookingFieldRequest(
      CreateBookingFieldPartyRequestParameter parameter);
  Future<BookingFieldPartyRequestEntity> getMyFieldPartyRequestById(int id);
  Future<Pagination<BookingFieldPartyRequestEntity>> getAllMyFieldPartyRequest(
      BookingFieldPartyRequestPaginationParameter pagination);
  Future<bool> deleteMyFieldPartyRequestById(int id, bool force_delete);
}

class BookingFieldPartyDSImpl implements BookingFieldPartyDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<CreateBookingFieldPartyResponseEntity> createBookingFieldRequest(
      CreateBookingFieldPartyRequestParameter parameter) async {
    try {
      final response = await httpUtils.post(
          ApiConstant.bookingFieldPartyRequestClientCreatePost,
          data: parameter.toJson());
      final result = CreateBookingFieldPartyResponseEntity.fromJson(response);
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
  Future<bool> deleteMyFieldPartyRequestById(int id, bool forceDelete) async {
    try {
      final response = await httpUtils.delete(
          ApiConstant.deleteMyBookingFieldPartyRequestClientDelete(id),
          queryParameters: {"force_delete": forceDelete.toString()});
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioError(e);
    } on ApiException catch (e) {
      throw ApiException(message: e.message, statusCode: e.statusCode);
    } on Exception catch (e) {
      throw ApiException(message: e.toString(), statusCode: 500);
    }
  }

  @override
  Future<Pagination<BookingFieldPartyRequestEntity>> getAllMyFieldPartyRequest(
      BookingFieldPartyRequestPaginationParameter pagination) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.allMyBookingFieldPartyRequestClientGet,
          queryParameters: pagination.toQueryParameters());
      final result = Pagination<BookingFieldPartyRequestEntity>.fromJson(
          response, BookingFieldPartyRequestEntity.fromJson);
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
  Future<BookingFieldPartyRequestEntity> getMyFieldPartyRequestById(
      int id) async {
    try {
      final response = await httpUtils
          .get(ApiConstant.getMyBookingFieldPartyRequestClientGet(id));
      final result = BookingFieldPartyRequestEntity.fromJson(response);
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
