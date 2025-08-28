typedef MultiDataMap = Map<String, List<String>>;

class PaginateProductParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? categoryIds;
  final List<int>? cityIds;
  final int? minPrice;
  final int? maxPrice;
  final int? gender;
  final bool? isForChildren;
  final bool? isRecommended;
  final bool? isActive;
  final bool? isShowDeleted;

  const PaginateProductParameter({
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.categoryIds,
    this.cityIds,
    this.minPrice,
    this.maxPrice,
    this.gender,
    this.isForChildren,
    this.isRecommended,
    this.isActive,
    this.isShowDeleted,
    this.perPage = 12,
    this.page = 1,
    this.search,
  });

  /// Используется, если нужна простая сериализация:
  Map<String, String> toFlatMap() {
    final Map<String, String> map = {};

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
    put("min_price", minPrice);
    put("max_price", maxPrice);
    put("gender", gender);
    put("is_for_children", isForChildren);
    put("is_recommended", isRecommended);
    put("is_active", isActive);
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
    put("min_price", minPrice);
    put("max_price", maxPrice);
    put("gender", gender);
    put("is_for_children", isForChildren);
    put("is_recommended", isRecommended);
    put("is_active", isActive);
    put("is_show_deleted", isShowDeleted);

    putList("category_ids", categoryIds);
    putList("city_ids", cityIds);

    return map;
  }

  PaginateProductParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? categoryIds,
    List<int>? cityIds,
    int? minPrice,
    int? maxPrice,
    int? gender,
    bool? isForChildren,
    bool? isRecommended,
    bool? isActive,
    bool? isShowDeleted,
  }) {
    return PaginateProductParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      categoryIds: categoryIds ?? this.categoryIds,
      cityIds: cityIds ?? this.cityIds,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      gender: gender ?? this.gender,
      isForChildren: isForChildren ?? this.isForChildren,
      isRecommended: isRecommended ?? this.isRecommended,
      isActive: isActive ?? this.isActive,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
