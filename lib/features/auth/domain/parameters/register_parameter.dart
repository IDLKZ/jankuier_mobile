class RegisterParameter {
  final int? roleId;
  final String email;
  final String phone;
  final String username;
  final String? iin;
  final String password;
  final String firstName;
  final String lastName;
  final String? patronymic;

  const RegisterParameter({
    this.roleId,
    required this.email,
    required this.phone,
    required this.username,
    this.iin,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.patronymic,
  });

  Map<String, dynamic> toJson() {
    return {
      'role_id': roleId,
      'email': email,
      'phone': phone,
      'username': username,
      'iin': iin,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'patronymic': patronymic,
    };
  }

  RegisterParameter copyWith({
    int? roleId,
    String? email,
    String? phone,
    String? username,
    String? iin,
    String? password,
    String? firstName,
    String? lastName,
    String? patronymic,
  }) {
    return RegisterParameter(
      roleId: roleId ?? this.roleId,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      username: username ?? this.username,
      iin: iin ?? this.iin,
      password: password ?? this.password,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      patronymic: patronymic ?? this.patronymic,
    );
  }
}
