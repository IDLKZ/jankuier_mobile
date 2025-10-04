class FirebaseNotificationClientCreateParameter {
  final String token;
  final bool isActive;

  const FirebaseNotificationClientCreateParameter({
    required this.token,
    this.isActive = true,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'is_active': isActive,
    };
  }

  FirebaseNotificationClientCreateParameter copyWith({
    String? token,
    bool? isActive,
  }) {
    return FirebaseNotificationClientCreateParameter(
      token: token ?? this.token,
      isActive: isActive ?? this.isActive,
    );
  }
}
