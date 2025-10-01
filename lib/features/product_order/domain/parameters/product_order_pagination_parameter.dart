typedef MultiDataMap = Map<String, List<String>>;

class ProductOrderPaginationParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? userIds;
  final List<int>? statusIds;
  final double? totalPriceFrom;
  final double? totalPriceTo;
  final bool? isActive;
  final bool? isCanceled;
  final bool? isPaid;
  final bool? isRefunded;
  final DateTime? paidFrom;
  final DateTime? paidTo;
  final DateTime? createdFrom;
  final DateTime? createdTo;
  final bool? isShowDeleted;

  const ProductOrderPaginationParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.userIds,
    this.statusIds,
    this.totalPriceFrom,
    this.totalPriceTo,
    this.isActive,
    this.isCanceled,
    this.isPaid,
    this.isRefunded,
    this.paidFrom,
    this.paidTo,
    this.createdFrom,
    this.createdTo,
    this.isShowDeleted,
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
    put("total_price_from", totalPriceFrom);
    put("total_price_to", totalPriceTo);
    put("is_active", isActive);
    put("is_canceled", isCanceled);
    put("is_paid", isPaid);
    put("is_refunded", isRefunded);
    put("paid_from", paidFrom);
    put("paid_to", paidTo);
    put("created_from", createdFrom);
    put("created_to", createdTo);
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
    put("total_price_from", totalPriceFrom);
    put("total_price_to", totalPriceTo);
    put("is_active", isActive);
    put("is_canceled", isCanceled);
    put("is_paid", isPaid);
    put("is_refunded", isRefunded);
    put("paid_from", paidFrom);
    put("paid_to", paidTo);
    put("created_from", createdFrom);
    put("created_to", createdTo);
    put("is_show_deleted", isShowDeleted);

    putList("user_ids", userIds);
    putList("status_ids", statusIds);

    return map;
  }

  ProductOrderPaginationParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? userIds,
    List<int>? statusIds,
    double? totalPriceFrom,
    double? totalPriceTo,
    bool? isActive,
    bool? isCanceled,
    bool? isPaid,
    bool? isRefunded,
    DateTime? paidFrom,
    DateTime? paidTo,
    DateTime? createdFrom,
    DateTime? createdTo,
    bool? isShowDeleted,
  }) {
    return ProductOrderPaginationParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      userIds: userIds ?? this.userIds,
      statusIds: statusIds ?? this.statusIds,
      totalPriceFrom: totalPriceFrom ?? this.totalPriceFrom,
      totalPriceTo: totalPriceTo ?? this.totalPriceTo,
      isActive: isActive ?? this.isActive,
      isCanceled: isCanceled ?? this.isCanceled,
      isPaid: isPaid ?? this.isPaid,
      isRefunded: isRefunded ?? this.isRefunded,
      paidFrom: paidFrom ?? this.paidFrom,
      paidTo: paidTo ?? this.paidTo,
      createdFrom: createdFrom ?? this.createdFrom,
      createdTo: createdTo ?? this.createdTo,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
