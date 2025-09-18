import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/domain/parameters/update_profile_parameter.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();

  @override
  List<Object?> get props => [];
}

class ProfileUpdateSubmitted extends UpdateProfileEvent {
  final UpdateProfileParameter updateProfileParameter;

  const ProfileUpdateSubmitted(this.updateProfileParameter);

  @override
  List<Object?> get props => [updateProfileParameter];
}

class ResetProfileUpdate extends UpdateProfileEvent {
  const ResetProfileUpdate();
}