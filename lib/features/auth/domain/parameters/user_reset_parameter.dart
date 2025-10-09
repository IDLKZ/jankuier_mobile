// Parameter для верификации кода
class UserCodeResetParameter {
  final String phone;
  final String code;
  final String newPassword;

  const UserCodeResetParameter({
    required this.phone,
    required this.code,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code,
      'new_password': newPassword,
    };
  }

  UserCodeResetParameter copyWith({
    String? phone,
    String? code,
    String? newPassword,
  }) {
    return UserCodeResetParameter(
      phone: phone ?? this.phone,
      code: code ?? this.code,
      newPassword: newPassword ?? this.newPassword,
    );
  }
}
