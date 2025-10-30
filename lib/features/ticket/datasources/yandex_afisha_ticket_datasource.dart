import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_yandex_afisha_parameter.dart';
import '../../../core/common/entities/pagination_entity.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/errors/exception.dart';
import '../../../core/utils/hive_utils.dart';
import '../../../core/utils/http_utils.dart';
import '../domain/parameters/all_yandex_afisha_ticket_parameter.dart';

abstract class YandexAfishaTicketDSInterface {
  Future<Pagination<YandexAfishaWidgetTicketEntity>> paginateTicketOrder(
      YandexAfishaWidgetTicketPaginationParameter parameter);
  Future<List<YandexAfishaWidgetTicketEntity>> allTicketOrder(
      AllYandexAfishaWidgetTicketFilterParameter parameter);
  Future<YandexAfishaWidgetTicketEntity> getYandexAfishaEntity(
      int yandexAfishaId);
}

@Injectable(as: YandexAfishaTicketDSInterface)
class YandexAfishaTicketDSImpl implements YandexAfishaTicketDSInterface {
  final httpUtils = HttpUtil();
  final hiveUtils = HiveUtils();

  @override
  Future<List<YandexAfishaWidgetTicketEntity>> allTicketOrder(
      AllYandexAfishaWidgetTicketFilterParameter parameter) async {
    try {
      final response = await httpUtils.get(ApiConstant.allYandexAfishaTickets,
          queryParameters: parameter.toQueryParameters());
      final result = YandexAfishaWidgetTicketListEntity.fromJsonList(response);
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
  Future<YandexAfishaWidgetTicketEntity> getYandexAfishaEntity(
      int yandexAfishaId) async {
    try {
      final response = await httpUtils
          .get(ApiConstant.GetYandexAfishaTicketByIdUrl(yandexAfishaId));
      final result = YandexAfishaWidgetTicketEntity.fromJson(response);
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
  Future<Pagination<YandexAfishaWidgetTicketEntity>> paginateTicketOrder(
      YandexAfishaWidgetTicketPaginationParameter parameter) async {
    try {
      final response = await httpUtils.get(
          ApiConstant.paginateYandexAfishaTickets,
          queryParameters: parameter.toQueryParameters());
      final result = Pagination<YandexAfishaWidgetTicketEntity>.fromJson(
          response, YandexAfishaWidgetTicketEntity.fromJson);
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
