import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/refresh_token_parameter.dart';

abstract class RefreshTokenEvent extends Equatable {
  const RefreshTokenEvent();

  @override
  List<Object?> get props => [];
}

class RefreshTokenSubmitted extends RefreshTokenEvent {
  final RefreshTokenParameter refreshTokenParameter;

  const RefreshTokenSubmitted(this.refreshTokenParameter);

  @override
  List<Object?> get props => [refreshTokenParameter];
}

class RefreshTokenReset extends RefreshTokenEvent {
  const RefreshTokenReset();
}
