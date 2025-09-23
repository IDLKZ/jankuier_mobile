// Parameter для верификации кода
class UserCodeVerificationParameter {
  final String phone;
  final String code;

  const UserCodeVerificationParameter({
    required this.phone,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      'phone': phone,
      'code': code,
    };
  }

  UserCodeVerificationParameter copyWith({
    String? phone,
    String? code,
  }) {
    return UserCodeVerificationParameter(
      phone: phone ?? this.phone,
      code: code ?? this.code,
    );
  }
}
