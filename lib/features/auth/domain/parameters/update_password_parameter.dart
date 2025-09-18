import 'package:equatable/equatable.dart';

class UpdatePasswordParameter extends Equatable {
  final String oldPassword;
  final String newPassword;

  const UpdatePasswordParameter({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'old_password': oldPassword,
      'new_password': newPassword,
    };
  }

  UpdatePasswordParameter copyWith({
    String? oldPassword,
    String? newPassword,
  }) {
    return UpdatePasswordParameter(
      oldPassword: oldPassword ?? this.oldPassword,
      newPassword: newPassword ?? this.newPassword,
    );
  }

  @override
  List<Object?> get props => [oldPassword, newPassword];
}
