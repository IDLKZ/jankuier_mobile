typedef MultiDataMap = Map<String, List<String>>;

class PaginateFieldPartyParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;

  final List<int>? fieldIds;

  final int? minPersonQty;
  final int? maxPersonQty;

  final int? minLengthM;
  final int? maxLengthM;

  final int? minWidthM;
  final int? maxWidthM;

  final int? coverType;
  final int? cityId;

  final bool? isActive;
  final bool? isCovered;
  final bool? isDefault;
  final bool? isShowDeleted;

  const PaginateFieldPartyParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.fieldIds,
    this.cityId,
    this.minPersonQty,
    this.maxPersonQty,
    this.minLengthM,
    this.maxLengthM,
    this.minWidthM,
    this.maxWidthM,
    this.coverType,
    this.isActive,
    this.isCovered,
    this.isDefault,
    this.isShowDeleted,
  });

  /// Сериализация в Map<String, String>
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
    put("min_person_qty", minPersonQty);
    put("max_person_qty", maxPersonQty);
    put("min_length_m", minLengthM);
    put("max_length_m", maxLengthM);
    put("min_width_m", minWidthM);
    put("max_width_m", maxWidthM);
    put("cover_type", coverType);
    put("city_id", cityId);
    put("is_active", isActive);
    put("is_covered", isCovered);
    put("is_default", isDefault);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  /// Сериализация в MultiDataMap (поддержка массивов)
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
    put("min_person_qty", minPersonQty);
    put("max_person_qty", maxPersonQty);
    put("min_length_m", minLengthM);
    put("max_length_m", maxLengthM);
    put("min_width_m", minWidthM);
    put("max_width_m", maxWidthM);
    put("cover_type", coverType);
    put("city_id", cityId);
    put("is_active", isActive);
    put("is_covered", isCovered);
    put("is_default", isDefault);
    put("is_show_deleted", isShowDeleted);

    putList("field_ids", fieldIds);

    return map;
  }

  PaginateFieldPartyParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? fieldIds,
    int? minPersonQty,
    int? maxPersonQty,
    int? minLengthM,
    int? maxLengthM,
    int? minWidthM,
    int? maxWidthM,
    int? coverType,
    int? cityId,
    bool? isActive,
    bool? isCovered,
    bool? isDefault,
    bool? isShowDeleted,
  }) {
    return PaginateFieldPartyParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      fieldIds: fieldIds ?? this.fieldIds,
      minPersonQty: minPersonQty ?? this.minPersonQty,
      maxPersonQty: maxPersonQty ?? this.maxPersonQty,
      minLengthM: minLengthM ?? this.minLengthM,
      maxLengthM: maxLengthM ?? this.maxLengthM,
      minWidthM: minWidthM ?? this.minWidthM,
      maxWidthM: maxWidthM ?? this.maxWidthM,
      coverType: coverType ?? this.coverType,
      cityId: cityId ?? this.cityId,
      isActive: isActive ?? this.isActive,
      isCovered: isCovered ?? this.isCovered,
      isDefault: isDefault ?? this.isDefault,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
