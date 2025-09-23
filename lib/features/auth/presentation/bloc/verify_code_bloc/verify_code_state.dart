import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_verification_entity.dart';

abstract class VerifyCodeState extends Equatable {
  const VerifyCodeState();

  @override
  List<Object?> get props => [];
}

class VerifyCodeInitial extends VerifyCodeState {
  const VerifyCodeInitial();
}

class VerifyCodeLoading extends VerifyCodeState {
  const VerifyCodeLoading();
}

class VerifyCodeSuccess extends VerifyCodeState {
  final UserCodeVerificationResultEntity result;

  const VerifyCodeSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class VerifyCodeFailure extends VerifyCodeState {
  final String message;

  const VerifyCodeFailure(this.message);

  @override
  List<Object?> get props => [message];
}