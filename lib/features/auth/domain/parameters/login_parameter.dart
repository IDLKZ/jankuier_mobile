class LoginParameter {
  final String username;
  final String password;

  const LoginParameter({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }

  LoginParameter copyWith({
    String? username,
    String? password,
  }) {
    return LoginParameter(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }
}
