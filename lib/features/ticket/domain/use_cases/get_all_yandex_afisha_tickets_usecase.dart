import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/yandex_afisha_ticket_repository.dart';
import 'package:jankuier_mobile/features/ticket/domain/parameters/all_yandex_afisha_ticket_parameter.dart';

@injectable
class GetAllYandexAfishaTicketsUseCase
    implements UseCase<List<YandexAfishaWidgetTicketEntity>, AllYandexAfishaWidgetTicketFilterParameter> {
  final YandexAfishaTicketRepository _repository;

  const GetAllYandexAfishaTicketsUseCase(this._repository);

  @override
  Future<Either<Failure, List<YandexAfishaWidgetTicketEntity>>> call(
      AllYandexAfishaWidgetTicketFilterParameter params) async {
    return await _repository.getAllTickets(params);
  }
}
