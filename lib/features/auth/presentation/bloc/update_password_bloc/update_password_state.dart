import 'package:equatable/equatable.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object?> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {
  const UpdatePasswordInitial();
}

class UpdatePasswordLoading extends UpdatePasswordState {
  const UpdatePasswordLoading();
}

class UpdatePasswordSuccess extends UpdatePasswordState {
  final String? successMessage;

  const UpdatePasswordSuccess({this.successMessage});

  @override
  List<Object?> get props => [successMessage];
}

class UpdatePasswordFailure extends UpdatePasswordState {
  final String message;

  const UpdatePasswordFailure(this.message);

  @override
  List<Object?> get props => [message];
}