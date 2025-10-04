import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/notifications/domain/parameters/firebase_notification_client_create_parameter.dart';

abstract class CreateOrUpdateFirebaseTokenEvent extends Equatable {
  const CreateOrUpdateFirebaseTokenEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrUpdateToken extends CreateOrUpdateFirebaseTokenEvent {
  final FirebaseNotificationClientCreateParameter parameter;

  const CreateOrUpdateToken(this.parameter);

  @override
  List<Object?> get props => [parameter];
}
