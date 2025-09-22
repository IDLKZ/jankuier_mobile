import 'package:equatable/equatable.dart';

// Entity для метаданных пагинации
class KffLeaguePaginationEntity extends Equatable {
  final int? page;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final bool? hasNext;
  final bool? hasPrev;
  final int? nextPage;
  final int? prevPage;
  final String? nextPageUrl;
  final String? prevPageUrl;

  const KffLeaguePaginationEntity({
    this.page,
    this.perPage,
    this.total,
    this.lastPage,
    this.hasNext,
    this.hasPrev,
    this.nextPage,
    this.prevPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory KffLeaguePaginationEntity.fromJson(Map<String, dynamic> json) {
    return KffLeaguePaginationEntity(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      lastPage: json['last_page'],
      hasNext: json['has_next'] ?? false,
      hasPrev: json['has_prev'] ?? false,
      nextPage: json['next_page'],
      prevPage: json['prev_page'],
      nextPageUrl: json['next_page_url'],
      prevPageUrl: json['prev_page_url'],
    );
  }

  @override
  List<Object?> get props => [
        page,
        perPage,
        total,
        lastPage,
        hasNext,
        hasPrev,
        nextPage,
        prevPage,
        nextPageUrl,
        prevPageUrl,
      ];
}

// Generic Entity для ответа с пагинацией
class KffLeaguePaginatedResponseEntity<T> extends Equatable {
  final bool success;
  final int code;
  final List<T> data;
  final KffLeaguePaginationEntity? meta;

  const KffLeaguePaginatedResponseEntity({
    required this.success,
    required this.code,
    required this.data,
    this.meta,
  });

  factory KffLeaguePaginatedResponseEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return KffLeaguePaginatedResponseEntity<T>(
      success: json['success'] ?? false,
      code: json['code'] ?? 0,
      data: json['data'] != null
          ? (json['data'] as List<dynamic>)
              .map((item) => fromJsonT(item))
              .toList()
          : <T>[],
      meta: json['meta'] != null
          ? KffLeaguePaginationEntity.fromJson(json['meta'])
          : null,
    );
  }

  @override
  List<Object?> get props => [success, code, data, meta];
}

// Generic Entity для ответа с одним объектом
class KffLeagueSingleResponseEntity<T> extends Equatable {
  final bool success;
  final int code;
  final T? data;
  final KffLeaguePaginationEntity? meta;

  const KffLeagueSingleResponseEntity({
    required this.success,
    required this.code,
    this.data,
    this.meta,
  });

  factory KffLeagueSingleResponseEntity.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return KffLeagueSingleResponseEntity<T>(
      success: json['success'] ?? false,
      code: json['code'] ?? 0,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
      meta: json['meta'] != null && (json['meta'] as Map).isNotEmpty
          ? KffLeaguePaginationEntity.fromJson(json['meta'])
          : null,
    );
  }

  @override
  List<Object?> get props => [success, code, data, meta];
}
