import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';

abstract class DeleteProfilePhotoState extends Equatable {
  const DeleteProfilePhotoState();

  @override
  List<Object?> get props => [];
}

class DeleteProfilePhotoInitial extends DeleteProfilePhotoState {
  const DeleteProfilePhotoInitial();
}

class DeleteProfilePhotoLoading extends DeleteProfilePhotoState {
  const DeleteProfilePhotoLoading();
}

class DeleteProfilePhotoSuccess extends DeleteProfilePhotoState {
  final UserEntity updatedUser;
  final String? successMessage;

  const DeleteProfilePhotoSuccess({
    required this.updatedUser,
    this.successMessage,
  });

  @override
  List<Object?> get props => [updatedUser, successMessage];
}

class DeleteProfilePhotoFailure extends DeleteProfilePhotoState {
  final String message;

  const DeleteProfilePhotoFailure(this.message);

  @override
  List<Object?> get props => [message];
}