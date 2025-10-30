typedef MultiDataMap = Map<String, List<String>>;

class AllYandexAfishaWidgetTicketFilterParameter {
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final bool? isActive;
  final DateTime? startAtFrom;
  final DateTime? startAtTo;
  final bool? isShowDeleted;

  const AllYandexAfishaWidgetTicketFilterParameter({
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.isActive = true,
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

    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("start_at_from", startAtFrom);
    put("start_at_to", startAtTo);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  AllYandexAfishaWidgetTicketFilterParameter copyWith({
    String? search,
    String? orderBy,
    String? orderDirection,
    bool? isActive,
    DateTime? startAtFrom,
    DateTime? startAtTo,
    bool? isShowDeleted,
  }) {
    return AllYandexAfishaWidgetTicketFilterParameter(
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
