import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/yandex_afisha_ticket/yandex_afisha_ticket_entity.dart';
import 'package:jankuier_mobile/features/ticket/domain/interface/yandex_afisha_ticket_repository.dart';

@injectable
class GetYandexAfishaTicketByIdUseCase implements UseCase<YandexAfishaWidgetTicketEntity, int> {
  final YandexAfishaTicketRepository _repository;

  const GetYandexAfishaTicketByIdUseCase(this._repository);

  @override
  Future<Either<Failure, YandexAfishaWidgetTicketEntity>> call(int params) async {
    return await _repository.getTicketById(params);
  }
}
