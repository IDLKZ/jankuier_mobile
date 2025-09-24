import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';

abstract class UpdateProfilePhotoState extends Equatable {
  const UpdateProfilePhotoState();

  @override
  List<Object?> get props => [];
}

class UpdateProfilePhotoInitial extends UpdateProfilePhotoState {
  const UpdateProfilePhotoInitial();
}

class UpdateProfilePhotoLoading extends UpdateProfilePhotoState {
  const UpdateProfilePhotoLoading();
}

class UpdateProfilePhotoSuccess extends UpdateProfilePhotoState {
  final UserEntity updatedUser;
  final String? successMessage;

  const UpdateProfilePhotoSuccess({
    required this.updatedUser,
    this.successMessage,
  });

  @override
  List<Object?> get props => [updatedUser, successMessage];
}

class UpdateProfilePhotoFailure extends UpdateProfilePhotoState {
  final String message;

  const UpdateProfilePhotoFailure(this.message);

  @override
  List<Object?> get props => [message];
}