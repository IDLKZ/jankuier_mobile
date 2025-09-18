import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/login_parameter.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object?> get props => [];
}

class SignInSubmitted extends SignInEvent {
  final LoginParameter loginParameter;

  const SignInSubmitted(this.loginParameter);

  @override
  List<Object?> get props => [loginParameter];
}

class SignInReset extends SignInEvent {
  const SignInReset();
}