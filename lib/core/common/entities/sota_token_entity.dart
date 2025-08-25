class SotaTokenEntity {
  final String access;
  final String refresh;
  final String? multiToken;

  SotaTokenEntity({
    required this.access,
    required this.refresh,
    this.multiToken,
  });

  factory SotaTokenEntity.fromJson(Map<String, dynamic> json) {
    return SotaTokenEntity(
      access: json['access'],
      refresh: json['refresh'],
      multiToken: json['multi_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access': access,
      'refresh': refresh,
      if (multiToken != null) 'multi_token': multiToken,
    };
  }
}
