import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/notifications/data/entities/firebase_notification_entity.dart';

abstract class GetFirebaseTokenState extends Equatable {
  const GetFirebaseTokenState();

  @override
  List<Object?> get props => [];
}

class FirebaseTokenInitial extends GetFirebaseTokenState {
  const FirebaseTokenInitial();
}

class FirebaseTokenLoading extends GetFirebaseTokenState {
  const FirebaseTokenLoading();
}

class FirebaseTokenLoaded extends GetFirebaseTokenState {
  final FirebaseNotificationEntity? token;

  const FirebaseTokenLoaded(this.token);

  @override
  List<Object?> get props => [token];
}

class FirebaseTokenError extends GetFirebaseTokenState {
  final String message;

  const FirebaseTokenError(this.message);

  @override
  List<Object?> get props => [message];
}
