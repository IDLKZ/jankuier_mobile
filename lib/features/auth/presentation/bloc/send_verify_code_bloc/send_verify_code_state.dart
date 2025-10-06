import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';

abstract class SendVerifyCodeState extends Equatable {
  const SendVerifyCodeState();

  @override
  List<Object?> get props => [];
}

class SendVerifyCodeInitial extends SendVerifyCodeState {
  const SendVerifyCodeInitial();
}

class SendVerifyCodeLoading extends SendVerifyCodeState {
  const SendVerifyCodeLoading();
}

class SendVerifyCodeSuccess extends SendVerifyCodeState {
  final UserCodeVerificationResultEntity result;

  const SendVerifyCodeSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class SendVerifyCodeFailure extends SendVerifyCodeState {
  final String message;

  const SendVerifyCodeFailure(this.message);

  @override
  List<Object?> get props => [message];
}
