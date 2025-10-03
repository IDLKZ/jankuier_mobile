import 'package:equatable/equatable.dart';

abstract class DeleteMyFieldPartyRequestByIdEvent extends Equatable {
  const DeleteMyFieldPartyRequestByIdEvent();

  @override
  List<Object?> get props => [];
}

class DeleteMyFieldPartyRequestByIdStarted
    extends DeleteMyFieldPartyRequestByIdEvent {
  final int id;
  final bool forceDelete;

  const DeleteMyFieldPartyRequestByIdStarted({
    required this.id,
    this.forceDelete = false,
  });

  @override
  List<Object?> get props => [id, forceDelete];
}
