import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/yandex_afisha_ticket_repository.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/paginate_yandex_afisha_parameter.dart';

@injectable
class PaginateYandexAfishaTicketsUseCase
    implements UseCase<Pagination<YandexAfishaWidgetTicketEntity>, YandexAfishaWidgetTicketPaginationParameter> {
  final YandexAfishaTicketRepository _repository;

  const PaginateYandexAfishaTicketsUseCase(this._repository);

  @override
  Future<Either<Failure, Pagination<YandexAfishaWidgetTicketEntity>>> call(
      YandexAfishaWidgetTicketPaginationParameter params) async {
    return await _repository.paginateTickets(params);
  }
}
