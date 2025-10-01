typedef MultiDataMap = Map<String, List<String>>;

// Parameter для фильтрации статусов элементов заказа
class ProductOrderItemStatusFilterParameter {
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final bool? isActive;
  final bool? isFirst;
  final bool? isLast;
  final bool? isShowDeleted;

  const ProductOrderItemStatusFilterParameter({
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.isActive,
    this.isFirst,
    this.isLast,
    this.isShowDeleted,
  });

  /// Сериализация в простой Map (одиночные значения)
  Map<String, String> toFlatMap() {
    final Map<String, String> map = {};

    void put<T>(String key, T? value) {
      if (value != null) {
        map[key] = value.toString();
      }
    }

    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("is_first", isFirst);
    put("is_last", isLast);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  /// Сериализация в MultiDataMap (множественные значения списками)
  MultiDataMap toQueryParameters() {
    final map = <String, List<String>>{};

    void put(String key, dynamic value) {
      if (value != null) {
        map[key] = [value.toString()];
      }
    }

    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("is_first", isFirst);
    put("is_last", isLast);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  ProductOrderItemStatusFilterParameter copyWith({
    String? search,
    String? orderBy,
    String? orderDirection,
    bool? isActive,
    bool? isFirst,
    bool? isLast,
    bool? isShowDeleted,
  }) {
    return ProductOrderItemStatusFilterParameter(
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      isActive: isActive ?? this.isActive,
      isFirst: isFirst ?? this.isFirst,
      isLast: isLast ?? this.isLast,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
