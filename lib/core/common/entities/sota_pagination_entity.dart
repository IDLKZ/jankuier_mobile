import 'package:equatable/equatable.dart';

class SotaPaginationResponse<T> extends Equatable {
  final int count;
  final String? next;
  final String? previous;
  final List<T> results;

  const SotaPaginationResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  /// Универсальный парсер: пробрасываем маппер элемента
  factory SotaPaginationResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final rawList = (json['results'] as List? ?? const []);
    return SotaPaginationResponse<T>(
      count: json['count'] as int? ?? 0,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results:
          rawList.map((e) => fromJsonT(e as Map<String, dynamic>)).toList(),
    );
  }

  /// Обратная сериализация: пробрасываем toJson маппер элемента
  Map<String, dynamic> toJson(
    Map<String, dynamic> Function(T) toJsonT,
  ) {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'results': results.map(toJsonT).toList(),
    };
  }

  bool get hasNext => next != null;
  bool get hasPrevious => previous != null;

  /// Вытаскивает номер следующей страницы из query (?page=2)
  int? get nextPageNumber {
    if (next == null) return null;
    final uri = Uri.tryParse(next!);
    final page = uri?.queryParameters['page'];
    return page == null ? null : int.tryParse(page);
  }

  /// Вытаскивает номер предыдущей страницы
  int? get previousPageNumber {
    if (previous == null) return null;
    final uri = Uri.tryParse(previous!);
    final page = uri?.queryParameters['page'];
    return page == null ? null : int.tryParse(page);
  }

  SotaPaginationResponse<T> copyWith({
    int? count,
    String? next,
    String? previous,
    List<T>? results,
  }) {
    return SotaPaginationResponse<T>(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [count, next, previous, results];
}
