class Pagination<T> {
  final int currentPage;
  final int perPage;
  final int lastPage;
  final int totalPages;
  final int totalItems;
  final List<T> items;

  const Pagination({
    required this.currentPage,
    required this.perPage,
    required this.lastPage,
    required this.totalPages,
    required this.totalItems,
    required this.items,
  });

  // Полезные геттеры
  bool get isFirstPage => currentPage == 1;
  bool get isLastPage => currentPage == lastPage;
  bool get hasNextPage => currentPage < lastPage;
  bool get hasPreviousPage => currentPage > 1;
  int get nextPage => hasNextPage ? currentPage + 1 : currentPage;
  int get previousPage => hasPreviousPage ? currentPage - 1 : currentPage;

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final itemsJson = json['items'] as List<dynamic>? ?? [];

    return Pagination<T>(
      currentPage: json['current_page'],
      perPage: json['per_page'],
      lastPage: json['last_page'],
      totalPages: json['total_pages'],
      totalItems: json['total_items'],
      items: itemsJson.map((item) => fromJsonT(item)).toList(),
    );
  }

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    return {
      'current_page': currentPage,
      'per_page': perPage,
      'last_page': lastPage,
      'total_pages': totalPages,
      'total_items': totalItems,
      'items': items.map(toJsonT).toList(),
    };
  }
}
