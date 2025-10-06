import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// Параметры для обновления PIN-кода
class ReloadPinParams extends Equatable {
  final String oldPin;
  final String newPin;

  const ReloadPinParams({required this.oldPin, required this.newPin});

  @override
  List<Object?> get props => [oldPin, newPin];
}

/// UseCase для обновления существующего PIN-кода
///
/// Для успешного обновления необходимо подтвердить старый PIN-код.
@injectable
class ReloadPinCodeUseCase implements UseCase<bool, ReloadPinParams> {
  final LocalAuthInterface repository;

  ReloadPinCodeUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(ReloadPinParams params) async {
    return await repository.reloadPinCode(params.oldPin, params.newPin);
  }
}
