import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/bearer_token_entity.dart';

abstract class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object?> get props => [];
}

class SignInInitial extends SignInState {
  const SignInInitial();
}

class SignInLoading extends SignInState {
  const SignInLoading();
}

class SignInSuccess extends SignInState {
  final BearerTokenEntity token;

  const SignInSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class SignInFailure extends SignInState {
  final String message;

  const SignInFailure(this.message);

  @override
  List<Object?> get props => [message];
}