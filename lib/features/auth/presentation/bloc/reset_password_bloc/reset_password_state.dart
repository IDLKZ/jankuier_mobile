import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_reset_entity.dart';

abstract class ResetPasswordState extends Equatable {
  const ResetPasswordState();

  @override
  List<Object?> get props => [];
}

class ResetPasswordInitial extends ResetPasswordState {
  const ResetPasswordInitial();
}

class ResetPasswordLoading extends ResetPasswordState {
  const ResetPasswordLoading();
}

class SendResetCodeSuccess extends ResetPasswordState {
  final UserCodeResetResultEntity result;

  const SendResetCodeSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class VerifyResetCodeSuccess extends ResetPasswordState {
  final UserCodeResetResultEntity result;

  const VerifyResetCodeSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class ResetPasswordFailure extends ResetPasswordState {
  final String message;

  const ResetPasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}
