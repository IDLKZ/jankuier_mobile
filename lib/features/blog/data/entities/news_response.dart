import 'package:equatable/equatable.dart';

import '../../data/entities/news_entity.dart';
import '../../data/entities/news_pagination.dart';

class NewsListResponse extends Equatable {
  final bool success;
  final int code;
  final List<News> data;
  final PaginationMeta meta;

  const NewsListResponse({
    required this.success,
    required this.code,
    required this.data,
    required this.meta,
  });

  factory NewsListResponse.fromJson(Map<String, dynamic> json) {
    final rawData = (json['data'] as List?) ?? const [];
    final rawMeta = (json['meta'] as Map?)?.cast<String, dynamic>();

    return NewsListResponse(
      success: _asBool(json['success'], fallback: true),
      code: _asInt(json['code'], fallback: 200),
      data: rawData
          .map((e) => News.fromJson((e as Map).cast<String, dynamic>()))
          .toList(),
      meta: rawMeta != null
          ? PaginationMeta.fromJson(rawMeta)
          : const PaginationMeta(
        page: 1,
        perPage: 25,
        total: 0,
        lastPage: 1,
        hasNext: false,
        hasPrev: false,
        nextPage: null,
        prevPage: null,
        nextPageUrl: null,
        prevPageUrl: null,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'code': code,
    'data': data.map((e) => e.toJson()).toList(),
    'meta': meta.toJson(),
  };

  NewsListResponse copyWith({
    bool? success,
    int? code,
    List<News>? data,
    PaginationMeta? meta,
  }) {
    return NewsListResponse(
      success: success ?? this.success,
      code: code ?? this.code,
      data: data ?? this.data,
      meta: meta ?? this.meta,
    );
  }

  @override
  List<Object?> get props => [success, code, data, meta];
}

class NewsOneResponse extends Equatable {
  final bool success;
  final int code;
  final News data;

  const NewsOneResponse({
    required this.success,
    required this.code,
    required this.data,
  });

  factory NewsOneResponse.fromJson(Map<String, dynamic> json) {
    final raw = (json['data'] as Map?)?.cast<String, dynamic>() ?? const {};
    return NewsOneResponse(
      success: _asBool(json['success'], fallback: true),
      code: _asInt(json['code'], fallback: 200),
      data: News.fromJson(raw),
    );
  }

  Map<String, dynamic> toJson() => {
    'success': success,
    'code': code,
    'data': data.toJson(),
  };

  NewsOneResponse copyWith({
    bool? success,
    int? code,
    News? data,
  }) {
    return NewsOneResponse(
      success: success ?? this.success,
      code: code ?? this.code,
      data: data ?? this.data,
    );
  }

  @override
  List<Object?> get props => [success, code, data];
}

// ---- helpers (локальные) ----
int _asInt(Object? v, {int fallback = 0}) {
  if (v is int) return v;
  if (v is num) return v.toInt();
  if (v is String) return int.tryParse(v) ?? fallback;
  return fallback;
}

bool _asBool(Object? v, {bool fallback = false}) {
  if (v is bool) return v;
  if (v is num) return v != 0;
  if (v is String) {
    final s = v.toLowerCase().trim();
    return s == '1' || s == 'true' || s == 'yes' || s == 'on';
  }
  return fallback;
}
