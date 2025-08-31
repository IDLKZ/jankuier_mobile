typedef MultiDataMap = Map<String, List<String>>;

class AllFieldPartyParameter {
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

  final bool? isActive;
  final bool? isCovered;
  final bool? isDefault;
  final bool? isShowDeleted;

  const AllFieldPartyParameter({
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.fieldIds,
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
    put("is_active", isActive);
    put("is_covered", isCovered);
    put("is_default", isDefault);
    put("is_show_deleted", isShowDeleted);

    putList("field_ids", fieldIds);

    return map;
  }

  AllFieldPartyParameter copyWith({
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
    bool? isActive,
    bool? isCovered,
    bool? isDefault,
    bool? isShowDeleted,
  }) {
    return AllFieldPartyParameter(
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
      isActive: isActive ?? this.isActive,
      isCovered: isCovered ?? this.isCovered,
      isDefault: isDefault ?? this.isDefault,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
