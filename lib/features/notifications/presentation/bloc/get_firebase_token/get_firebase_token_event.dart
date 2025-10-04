import 'package:equatable/equatable.dart';

abstract class GetFirebaseTokenEvent extends Equatable {
  const GetFirebaseTokenEvent();

  @override
  List<Object?> get props => [];
}

class LoadFirebaseToken extends GetFirebaseTokenEvent {
  const LoadFirebaseToken();
}
