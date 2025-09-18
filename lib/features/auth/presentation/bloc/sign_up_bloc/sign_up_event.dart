import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/register_parameter.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  final RegisterParameter registerParameter;

  const SignUpSubmitted(this.registerParameter);

  @override
  List<Object?> get props => [registerParameter];
}

class SignUpReset extends SignUpEvent {
  const SignUpReset();
}