import 'package:equatable/equatable.dart';

class BearerTokenEntity extends Equatable {
  final String accessToken;
  final String? refreshToken;

  const BearerTokenEntity({
    required this.accessToken,
    this.refreshToken,
  });

  factory BearerTokenEntity.fromJson(Map<String, dynamic> json) {
    return BearerTokenEntity(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

class BearerTokenListEntity {
  static List<BearerTokenEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => BearerTokenEntity.fromJson(json)).toList();
  }
}
