typedef MultiDataMap = Map<String, List<String>>;

class YandexAfishaWidgetTicketPaginationParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final bool? isActive;
  final DateTime? startAtFrom;
  final DateTime? startAtTo;
  final bool? isShowDeleted;

  const YandexAfishaWidgetTicketPaginationParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.isActive,
    this.startAtFrom,
    this.startAtTo,
    this.isShowDeleted = false,
  });

  /// Сериализация в простой Map (одиночные значения)
  Map<String, String> toFlatMap() {
    final Map<String, String> map = {};

    void put<T>(String key, T? value) {
      if (value != null) {
        if (value is DateTime) {
          map[key] = value.toIso8601String();
        } else {
          map[key] = value.toString();
        }
      }
    }

    put("per_page", perPage);
    put("page", page);
    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("start_at_from", startAtFrom);
    put("start_at_to", startAtTo);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  /// Сериализация в MultiDataMap (множественные значения списками)
  MultiDataMap toQueryParameters() {
    final map = <String, List<String>>{};

    void put(String key, dynamic value) {
      if (value != null) {
        if (value is DateTime) {
          map[key] = [value.toIso8601String()];
        } else {
          map[key] = [value.toString()];
        }
      }
    }

    put("per_page", perPage);
    put("page", page);
    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("start_at_from", startAtFrom);
    put("start_at_to", startAtTo);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  YandexAfishaWidgetTicketPaginationParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    bool? isActive,
    DateTime? startAtFrom,
    DateTime? startAtTo,
    bool? isShowDeleted,
  }) {
    return YandexAfishaWidgetTicketPaginationParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      isActive: isActive ?? this.isActive,
      startAtFrom: startAtFrom ?? this.startAtFrom,
      startAtTo: startAtTo ?? this.startAtTo,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
