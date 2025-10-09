import 'package:equatable/equatable.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object?> get props => [];
}

class SendResetCodeSubmitted extends ResetPasswordEvent {
  final String phone;

  const SendResetCodeSubmitted(this.phone);

  @override
  List<Object?> get props => [phone];
}

class VerifyResetCodeSubmitted extends ResetPasswordEvent {
  final String phone;
  final String code;
  final String newPassword;

  const VerifyResetCodeSubmitted({
    required this.phone,
    required this.code,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [phone, code, newPassword];
}

class ResetPasswordReset extends ResetPasswordEvent {
  const ResetPasswordReset();
}
