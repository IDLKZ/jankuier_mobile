import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';

abstract class GetMeState extends Equatable {
  const GetMeState();

  @override
  List<Object?> get props => [];
}

class GetMeInitial extends GetMeState {
  const GetMeInitial();
}

class GetMeLoading extends GetMeState {
  const GetMeLoading();
}

class GetMeLoaded extends GetMeState {
  final UserEntity user;

  const GetMeLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class GetMeError extends GetMeState {
  final String message;

  const GetMeError(this.message);

  @override
  List<Object?> get props => [message];
}