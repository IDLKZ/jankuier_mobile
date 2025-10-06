import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// UseCase для проверки наличия установленного PIN-кода
///
/// Используется для определения, нужно ли показывать экран
/// установки PIN-кода или экран входа по PIN-коду.
@injectable
class GetPinHashBeforeUseCase implements UseCase<bool, NoParams> {
  final LocalAuthInterface repository;

  GetPinHashBeforeUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.getPinHashBefore();
  }
}
