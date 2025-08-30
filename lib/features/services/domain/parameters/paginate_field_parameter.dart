typedef MultiDataMap = Map<String, List<String>>;

class PaginateFieldParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? cityIds;
  final bool? isActive;
  final bool? hasCover;
  final bool? isShowDeleted;

  const PaginateFieldParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.cityIds,
    this.isActive,
    this.hasCover,
    this.isShowDeleted,
  });

  /// Используется, если нужна простая сериализация (Map<String, String>)
  Map<String, String> toFlatMap() {
    final map = <String, String>{};

    void put<T>(String key, T? value) {
      if (value != null) {
        map[key] = value.toString();
      }
    }

    put("per_page", perPage);
    put("page", page);
    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("has_cover", hasCover);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  /// Используется, если API ожидает множественные параметры (`key=value&key=value`)
  MultiDataMap toQueryParameters() {
    final map = <String, List<String>>{};

    void put(String key, dynamic value) {
      if (value != null) {
        map[key] = [value.toString()];
      }
    }

    void putList(String key, List<int>? values) {
      if (values != null && values.isNotEmpty) {
        map[key] = values.map((e) => e.toString()).toList();
      }
    }

    put("per_page", perPage);
    put("page", page);
    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_active", isActive);
    put("has_cover", hasCover);
    put("is_show_deleted", isShowDeleted);

    putList("city_ids", cityIds);

    return map;
  }

  PaginateFieldParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? cityIds,
    bool? isActive,
    bool? hasCover,
    bool? isShowDeleted,
  }) {
    return PaginateFieldParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      cityIds: cityIds ?? this.cityIds,
      isActive: isActive ?? this.isActive,
      hasCover: hasCover ?? this.hasCover,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
