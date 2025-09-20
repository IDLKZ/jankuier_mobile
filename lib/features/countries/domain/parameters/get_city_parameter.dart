typedef MultiDataMap = Map<String, List<String>>;

class CityFilterParameter {
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? countryIds;
  final bool? isShowDeleted;

  const CityFilterParameter({
    this.search,
    this.orderBy = "title_ru",
    this.orderDirection = "asc",
    this.countryIds,
    this.isShowDeleted = false,
  });

  Map<String, String> toFlatMap() {
    final map = <String, String>{};

    void put<T>(String key, T? value) {
      if (value != null) {
        map[key] = value.toString();
      }
    }

    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
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

    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_show_deleted", isShowDeleted);

    putList("country_ids", countryIds);

    return map;
  }

  CityFilterParameter copyWith({
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? countryIds,
    bool? isShowDeleted,
  }) {
    return CityFilterParameter(
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      countryIds: countryIds ?? this.countryIds,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
