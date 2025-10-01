import 'package:equatable/equatable.dart';

abstract class DeleteAccountEvent extends Equatable {
  const DeleteAccountEvent();

  @override
  List<Object?> get props => [];
}

class DeleteAccountSubmitted extends DeleteAccountEvent {
  const DeleteAccountSubmitted();
}

class ResetDeleteAccount extends DeleteAccountEvent {
  const ResetDeleteAccount();
}