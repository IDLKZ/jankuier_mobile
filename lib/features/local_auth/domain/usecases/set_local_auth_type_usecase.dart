import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import '../repository/local_auth_interface.dart';

/// Параметры для установки типа локальной аутентификации
class LocalAuthTypeParams extends Equatable {
  final String authType;

  const LocalAuthTypeParams({required this.authType});

  @override
  List<Object?> get props => [authType];
}

/// UseCase для установки типа локальной аутентификации
///
/// Сохраняет выбранный пользователем тип аутентификации
/// для последующего использования при входе в приложение.
@injectable
class SetLocalAuthTypeUseCase implements UseCase<bool, LocalAuthTypeParams> {
  final LocalAuthInterface repository;

  SetLocalAuthTypeUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(LocalAuthTypeParams params) async {
    return await repository.setLocalAuthType(params.authType);
  }
}
