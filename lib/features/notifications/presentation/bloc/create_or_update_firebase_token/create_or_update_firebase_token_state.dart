import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';

abstract class CreateOrUpdateFirebaseTokenState extends Equatable {
  const CreateOrUpdateFirebaseTokenState();

  @override
  List<Object?> get props => [];
}

class CreateOrUpdateTokenInitial extends CreateOrUpdateFirebaseTokenState {
  const CreateOrUpdateTokenInitial();
}

class CreateOrUpdateTokenLoading extends CreateOrUpdateFirebaseTokenState {
  const CreateOrUpdateTokenLoading();
}

class CreateOrUpdateTokenSuccess extends CreateOrUpdateFirebaseTokenState {
  final FirebaseNotificationEntity token;

  const CreateOrUpdateTokenSuccess(this.token);

  @override
  List<Object?> get props => [token];
}

class CreateOrUpdateTokenError extends CreateOrUpdateFirebaseTokenState {
  final String message;

  const CreateOrUpdateTokenError(this.message);

  @override
  List<Object?> get props => [message];
}
