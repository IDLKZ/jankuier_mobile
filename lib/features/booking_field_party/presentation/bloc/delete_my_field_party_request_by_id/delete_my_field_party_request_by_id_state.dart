import 'package:equatable/equatable.dart';

abstract class DeleteMyFieldPartyRequestByIdState extends Equatable {
  const DeleteMyFieldPartyRequestByIdState();

  @override
  List<Object?> get props => [];
}

class DeleteMyFieldPartyRequestByIdInitial
    extends DeleteMyFieldPartyRequestByIdState {
  const DeleteMyFieldPartyRequestByIdInitial();
}

class DeleteMyFieldPartyRequestByIdLoading
    extends DeleteMyFieldPartyRequestByIdState {
  const DeleteMyFieldPartyRequestByIdLoading();
}

class DeleteMyFieldPartyRequestByIdSuccess
    extends DeleteMyFieldPartyRequestByIdState {
  final int deletedId;

  const DeleteMyFieldPartyRequestByIdSuccess(this.deletedId);

  @override
  List<Object?> get props => [deletedId];
}

class DeleteMyFieldPartyRequestByIdError
    extends DeleteMyFieldPartyRequestByIdState {
  final String message;

  const DeleteMyFieldPartyRequestByIdError(this.message);

  @override
  List<Object?> get props => [message];
}
