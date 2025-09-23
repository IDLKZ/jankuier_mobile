import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/user_verification_parameter.dart';

abstract class VerifyCodeEvent extends Equatable {
  const VerifyCodeEvent();

  @override
  List<Object?> get props => [];
}

class VerifyCodeSubmitted extends VerifyCodeEvent {
  final UserCodeVerificationParameter parameter;

  const VerifyCodeSubmitted(this.parameter);

  @override
  List<Object?> get props => [parameter];
}

class VerifyCodeReset extends VerifyCodeEvent {
  const VerifyCodeReset();
}