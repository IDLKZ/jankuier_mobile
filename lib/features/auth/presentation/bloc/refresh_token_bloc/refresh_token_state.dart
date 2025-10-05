import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';

abstract class RefreshTokenState extends Equatable {
  const RefreshTokenState();

  @override
  List<Object?> get props => [];
}

class RefreshTokenInitial extends RefreshTokenState {
  const RefreshTokenInitial();
}

class RefreshTokenLoading extends RefreshTokenState {
  const RefreshTokenLoading();
}

class RefreshTokenSuccess extends RefreshTokenState {
  final BearerTokenEntity token;

  const RefreshTokenSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class RefreshTokenFailure extends RefreshTokenState {
  final String message;
  final Failure? failure;

  const RefreshTokenFailure(this.message, {this.failure});

  @override
  List<Object?> get props => [message, failure];
}
