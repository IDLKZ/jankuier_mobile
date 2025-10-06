import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// Параметры для проверки PIN-кода
class PinCodeParams extends Equatable {
  final String pin;

  const PinCodeParams({required this.pin});

  @override
  List<Object?> get props => [pin];
}

/// UseCase для проверки введенного PIN-кода
///
/// Сравнивает переданный PIN-код с сохраненным в безопасном хранилище.
@injectable
class CheckPinCodeUseCase implements UseCase<bool, PinCodeParams> {
  final LocalAuthInterface repository;

  CheckPinCodeUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(PinCodeParams params) async {
    return await repository.checkPinCode(params.pin);
  }
}
