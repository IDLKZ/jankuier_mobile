typedef MultiDataMap = Map<String, List<String>>;

class PaginateAcademyParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? cityIds;
  final int? gender; // 0-любой, 1-мужской, 2-женский
  final bool? isActive;

  final int? minAgeFrom;
  final int? minAgeTo;
  final int? maxAgeFrom;
  final int? maxAgeTo;

  final double? averagePriceFrom;
  final double? averagePriceTo;

  final bool? isShowDeleted;

  const PaginateAcademyParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.cityIds,
    this.gender,
    this.isActive,
    this.minAgeFrom,
    this.minAgeTo,
    this.maxAgeFrom,
    this.maxAgeTo,
    this.averagePriceFrom,
    this.averagePriceTo,
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

    put("per_page", perPage);
    put("page", page);
    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("gender", gender);
    put("is_active", isActive);
    put("min_age_from", minAgeFrom);
    put("min_age_to", minAgeTo);
    put("max_age_from", maxAgeFrom);
    put("max_age_to", maxAgeTo);
    put("average_price_from", averagePriceFrom);
    put("average_price_to", averagePriceTo);
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
    put("gender", gender);
    put("is_active", isActive);
    put("min_age_from", minAgeFrom);
    put("min_age_to", minAgeTo);
    put("max_age_from", maxAgeFrom);
    put("max_age_to", maxAgeTo);
    put("average_price_from", averagePriceFrom);
    put("average_price_to", averagePriceTo);
    put("is_show_deleted", isShowDeleted);

    putList("city_ids", cityIds);

    return map;
  }

  PaginateAcademyParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? cityIds,
    int? gender,
    bool? isActive,
    int? minAgeFrom,
    int? minAgeTo,
    int? maxAgeFrom,
    int? maxAgeTo,
    double? averagePriceFrom,
    double? averagePriceTo,
    bool? isShowDeleted,
  }) {
    return PaginateAcademyParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      cityIds: cityIds ?? this.cityIds,
      gender: gender ?? this.gender,
      isActive: isActive ?? this.isActive,
      minAgeFrom: minAgeFrom ?? this.minAgeFrom,
      minAgeTo: minAgeTo ?? this.minAgeTo,
      maxAgeFrom: maxAgeFrom ?? this.maxAgeFrom,
      maxAgeTo: maxAgeTo ?? this.maxAgeTo,
      averagePriceFrom: averagePriceFrom ?? this.averagePriceFrom,
      averagePriceTo: averagePriceTo ?? this.averagePriceTo,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
