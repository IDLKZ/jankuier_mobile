import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/all_yandex_afisha_ticket_parameter.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_yandex_afisha_parameter.dart';

abstract class YandexAfishaTicketRepository {
  Future<Either<Failure, Pagination<YandexAfishaWidgetTicketEntity>>> paginateTickets(
      YandexAfishaWidgetTicketPaginationParameter parameter);

  Future<Either<Failure, List<YandexAfishaWidgetTicketEntity>>> getAllTickets(
      AllYandexAfishaWidgetTicketFilterParameter parameter);

  Future<Either<Failure, YandexAfishaWidgetTicketEntity>> getTicketById(
      int yandexAfishaId);
}
