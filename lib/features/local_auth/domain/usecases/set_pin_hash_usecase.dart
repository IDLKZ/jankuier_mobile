import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// Параметры для установки PIN-кода
class SetPinParams extends Equatable {
  final String pin;

  const SetPinParams({required this.pin});

  @override
  List<Object?> get props => [pin];
}

/// UseCase для установки нового PIN-кода
///
/// Сохраняет PIN-код только если он еще не был установлен ранее.
@injectable
class SetPinHashUseCase implements UseCase<bool, SetPinParams> {
  final LocalAuthInterface repository;

  SetPinHashUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(SetPinParams params) async {
    return await repository.setPinHash(params.pin);
  }
}
