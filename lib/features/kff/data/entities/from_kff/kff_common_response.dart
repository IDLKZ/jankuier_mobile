class KffCommonResponseFromList<T> {
  final bool success;
  final int code;
  final List<T> data;

  const KffCommonResponseFromList({
    required this.success,
    required this.code,
    required this.data,
  });

  factory KffCommonResponseFromList.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final itemsJson = json['data'] as List<dynamic>? ?? [];

    return KffCommonResponseFromList<T>(
      success: json['success'],
      code: json['code'],
      data: itemsJson.map((item) => fromJsonT(item)).toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'code': code,
      'data': data.map(toJsonT).toList(),
    };
  }
}

class KffCommonResponseFromEntity<T> {
  final bool success;
  final int code;
  final T data;

  const KffCommonResponseFromEntity({
    required this.success,
    required this.code,
    required this.data,
  });

  factory KffCommonResponseFromEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return KffCommonResponseFromEntity<T>(
      success: json['success'],
      code: json['code'],
      data: fromJsonT(json['data']),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'success': success,
      'code': code,
      'data': toJsonT(data),
    };
  }
}
