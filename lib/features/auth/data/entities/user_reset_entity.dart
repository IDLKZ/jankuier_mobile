import 'package:equatable/equatable.dart';

class UserCodeResetResultEntity extends Equatable {
  final int? userId;
  final String phone;
  final bool result;
  final int expiresInSeconds;
  final String? message;

  const UserCodeResetResultEntity({
    this.userId,
    required this.phone,
    required this.result,
    required this.expiresInSeconds,
    this.message,
  });

  factory UserCodeResetResultEntity.fromJson(Map<String, dynamic> json) {
    return UserCodeResetResultEntity(
      userId: json['user_id'],
      phone: json['phone'] ?? '',
      result: json['result'] ?? false,
      expiresInSeconds: json['expires_in_seconds'] ?? 0,
      message: json['message'],
    );
  }

  @override
  List<Object?> get props => [userId, phone, result, expiresInSeconds, message];
}
