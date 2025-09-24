import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class UpdateProfilePhotoEvent extends Equatable {
  const UpdateProfilePhotoEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProfilePhotoSubmitted extends UpdateProfilePhotoEvent {
  final File photoFile;

  const UpdateProfilePhotoSubmitted(this.photoFile);

  @override
  List<Object?> get props => [photoFile];
}

class ResetUpdateProfilePhoto extends UpdateProfilePhotoEvent {
  const ResetUpdateProfilePhoto();
}