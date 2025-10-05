class RefreshTokenParameter {
  final String refreshToken;

  const RefreshTokenParameter({
    required this.refreshToken,
  });

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
    };
  }

  RefreshTokenParameter copyWith({
    String? refreshToken,
  }) {
    return RefreshTokenParameter(
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }
}
