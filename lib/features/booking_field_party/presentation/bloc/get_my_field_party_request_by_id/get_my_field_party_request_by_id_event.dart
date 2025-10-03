import 'package:equatable/equatable.dart';

abstract class GetMyFieldPartyRequestByIdEvent extends Equatable {
  const GetMyFieldPartyRequestByIdEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyFieldPartyRequestById extends GetMyFieldPartyRequestByIdEvent {
  final int id;

  const LoadMyFieldPartyRequestById(this.id);

  @override
  List<Object?> get props => [id];
}
