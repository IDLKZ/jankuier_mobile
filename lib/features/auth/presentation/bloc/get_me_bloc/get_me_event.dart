import 'package:equatable/equatable.dart';

abstract class GetMeEvent extends Equatable {
  const GetMeEvent();

  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends GetMeEvent {
  const LoadUserProfile();
}

class RefreshUserProfile extends GetMeEvent {
  const RefreshUserProfile();
}

class ResetUserProfile extends GetMeEvent {
  const ResetUserProfile();
}

class LoadUserFromCache extends GetMeEvent {
  const LoadUserFromCache();
}
