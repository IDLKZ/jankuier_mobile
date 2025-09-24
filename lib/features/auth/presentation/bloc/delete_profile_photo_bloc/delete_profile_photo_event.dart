import 'package:equatable/equatable.dart';

abstract class DeleteProfilePhotoEvent extends Equatable {
  const DeleteProfilePhotoEvent();

  @override
  List<Object?> get props => [];
}

class DeleteProfilePhotoSubmitted extends DeleteProfilePhotoEvent {
  const DeleteProfilePhotoSubmitted();
}

class ResetDeleteProfilePhoto extends DeleteProfilePhotoEvent {
  const ResetDeleteProfilePhoto();
}