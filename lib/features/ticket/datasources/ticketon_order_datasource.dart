import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/constants/api_constants.dart';
import 'package:jankuier_mobile/core/utils/http_utils.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/shows/ticketon_shows_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/ticketon_get_shows_parameter.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/utils/hive_utils.dart';
import '../data/entities/ticket_order/ticketon_order_check_entity.dart';
import '../data/entities/ticket_order/ticketon_ticket_check_entity.dart';
import '../domain/parameters/all_ticketon_order_parameter.dart';
import '../domain/parameters/paginate_ticketon_order_parameter.dart';

abstract class TicketonOrderDSInterface {
  Future<Pagination<TicketonOrderEntity>> paginateTicketOrder(
      PaginateTicketonOrderParameter parameter);
  Future<TicketonOrderEntity> getTicketOrder(int ticketOrderId);
  Future<TicketonOrderCheckCommonResponseEntity> ticketonOrderCheck(
      int ticketOrderId);
  Future<TicketonTicketCheckCommonResponseEntity> ticketonTicketCheck(
      int ticketOrderId, String ticketId);
}

@Injectable(as: TicketonOrderDSInterface)
class TicketonOrderDSImpl implements TicketonOrderDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<Pagination<TicketonOrderEntity>> paginateTicketOrder(
      PaginateTicketonOrderParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.PaginateClientTicketOrderUrl,
          queryParameters: parameter.toQueryParameters());
      final result = Pagination<TicketonOrderEntity>.fromJson(
          response, TicketonOrderEntity.fromJson);
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
  Future<TicketonOrderEntity> getTicketOrder(int ticketOrderId) async {
    try {
      final response =
          await httpUtils.get(ApiConstant.GetMyTicketOrderUrl(ticketOrderId));
      final result = TicketonOrderEntity.fromJson(response);
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
  Future<TicketonOrderCheckCommonResponseEntity> ticketonOrderCheck(
      int ticketOrderId) async {
    try {
      final response =
          await httpUtils.get(ApiConstant.GetCheckOrderUrl(ticketOrderId));
      final result = TicketonOrderCheckCommonResponseEntity.fromJson(response);
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
  Future<TicketonTicketCheckCommonResponseEntity> ticketonTicketCheck(
      int ticketOrderId, String ticketId) async {
    try {
      final response = await httpUtils
          .get(ApiConstant.GetCheckTicketUrl(ticketOrderId, ticketId));
      final result = TicketonTicketCheckCommonResponseEntity.fromJson(response);
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
