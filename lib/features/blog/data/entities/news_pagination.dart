import 'package:equatable/equatable.dart';

class PaginationMeta extends Equatable {
  final int page;
  final int perPage;
  final int total;
  final int lastPage;
  final bool hasNext;
  final bool hasPrev;
  final int? nextPage;
  final int? prevPage;
  final String? nextPageUrl;
  final String? prevPageUrl;

  const PaginationMeta({
    required this.page,
    required this.perPage,
    required this.total,
    required this.lastPage,
    required this.hasNext,
    required this.hasPrev,
    this.nextPage,
    this.prevPage,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PaginationMeta.fromJson(Map<String, dynamic> json) {
    return PaginationMeta(
      page: _asInt(json['page']),
      perPage: _asInt(json['per_page']),
      total: _asInt(json['total']),
      lastPage: _asInt(json['last_page']),
      hasNext: _asBool(json['has_next']),
      hasPrev: _asBool(json['has_prev']),
      nextPage: _asNullableInt(json['next_page']),
      prevPage: _asNullableInt(json['prev_page']),
      nextPageUrl: _asNullableString(json['next_page_url']),
      prevPageUrl: _asNullableString(json['prev_page_url']),
    );
  }

  Map<String, dynamic> toJson() => {
    'page': page,
    'per_page': perPage,
    'total': total,
    'last_page': lastPage,
    'has_next': hasNext,
    'has_prev': hasPrev,
    'next_page': nextPage,
    'prev_page': prevPage,
    'next_page_url': nextPageUrl,
    'prev_page_url': prevPageUrl,
  };

  PaginationMeta copyWith({
    int? page,
    int? perPage,
    int? total,
    int? lastPage,
    bool? hasNext,
    bool? hasPrev,
    int? nextPage,
    int? prevPage,
    String? nextPageUrl,
    String? prevPageUrl,
  }) {
    return PaginationMeta(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      total: total ?? this.total,
      lastPage: lastPage ?? this.lastPage,
      hasNext: hasNext ?? this.hasNext,
      hasPrev: hasPrev ?? this.hasPrev,
      nextPage: nextPage ?? this.nextPage,
      prevPage: prevPage ?? this.prevPage,
      nextPageUrl: nextPageUrl ?? this.nextPageUrl,
      prevPageUrl: prevPageUrl ?? this.prevPageUrl,
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

  // ---- helpers ----
  static int _asInt(Object? v) {
    if (v is int) return v;
    if (v is String) return int.tryParse(v) ?? 0;
    if (v is num) return v.toInt();
    return 0;
  }

  static int? _asNullableInt(Object? v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is String) return int.tryParse(v);
    if (v is num) return v.toInt();
    return null;
  }

  static bool _asBool(Object? v) {
    if (v is bool) return v;
    if (v is num) return v != 0;
    if (v is String) {
      final s = v.toLowerCase().trim();
      return s == '1' || s == 'true' || s == 'yes' || s == 'on';
    }
    return false;
  }

  static String? _asNullableString(Object? v) {
    if (v == null) return null;
    final s = v.toString().trim();
    return s.isEmpty ? null : s;
  }
}
