import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_password_parameter.dart';

abstract class UpdatePasswordEvent extends Equatable {
  const UpdatePasswordEvent();

  @override
  List<Object?> get props => [];
}

class PasswordUpdateSubmitted extends UpdatePasswordEvent {
  final UpdatePasswordParameter updatePasswordParameter;

  const PasswordUpdateSubmitted(this.updatePasswordParameter);

  @override
  List<Object?> get props => [updatePasswordParameter];
}

class ResetPasswordUpdate extends UpdatePasswordEvent {
  const ResetPasswordUpdate();
}