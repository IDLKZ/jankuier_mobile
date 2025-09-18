import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';

abstract class UpdateProfileState extends Equatable {
  const UpdateProfileState();

  @override
  List<Object?> get props => [];
}

class UpdateProfileInitial extends UpdateProfileState {
  const UpdateProfileInitial();
}

class UpdateProfileLoading extends UpdateProfileState {
  const UpdateProfileLoading();
}

class UpdateProfileSuccess extends UpdateProfileState {
  final UserEntity updatedUser;
  final String? successMessage;

  const UpdateProfileSuccess({
    required this.updatedUser,
    this.successMessage,
  });

  @override
  List<Object?> get props => [updatedUser, successMessage];
}

class UpdateProfileFailure extends UpdateProfileState {
  final String message;

  const UpdateProfileFailure(this.message);

  @override
  List<Object?> get props => [message];
}