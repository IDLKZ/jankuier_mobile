typedef MultiDataMap = Map<String, List<String>>;

class ProductOrderItemPaginationParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? orderIds;
  final List<int>? statusIds;
  final List<int>? productIds;
  final List<int>? variantIds;
  final List<int>? fromCityIds;
  final List<int>? toCityIds;
  final double? totalPriceFrom;
  final double? totalPriceTo;
  final int? qtyFrom;
  final int? qtyTo;
  final bool? isActive;
  final bool? isCanceled;
  final bool? isPaid;
  final bool? isRefunded;
  final DateTime? deliveryFrom;
  final DateTime? deliveryTo;
  final DateTime? createdFrom;
  final DateTime? createdTo;
  final bool? isShowDeleted;

  const ProductOrderItemPaginationParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.orderIds,
    this.statusIds,
    this.productIds,
    this.variantIds,
    this.fromCityIds,
    this.toCityIds,
    this.totalPriceFrom,
    this.totalPriceTo,
    this.qtyFrom,
    this.qtyTo,
    this.isActive,
    this.isCanceled,
    this.isPaid,
    this.isRefunded,
    this.deliveryFrom,
    this.deliveryTo,
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
    put("qty_from", qtyFrom);
    put("qty_to", qtyTo);
    put("is_active", isActive);
    put("is_canceled", isCanceled);
    put("is_paid", isPaid);
    put("is_refunded", isRefunded);
    put("delivery_from", deliveryFrom);
    put("delivery_to", deliveryTo);
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
    put("qty_from", qtyFrom);
    put("qty_to", qtyTo);
    put("is_active", isActive);
    put("is_canceled", isCanceled);
    put("is_paid", isPaid);
    put("is_refunded", isRefunded);
    put("delivery_from", deliveryFrom);
    put("delivery_to", deliveryTo);
    put("created_from", createdFrom);
    put("created_to", createdTo);
    put("is_show_deleted", isShowDeleted);

    putList("order_ids", orderIds);
    putList("status_ids", statusIds);
    putList("product_ids", productIds);
    putList("variant_ids", variantIds);
    putList("from_city_ids", fromCityIds);
    putList("to_city_ids", toCityIds);

    return map;
  }

  ProductOrderItemPaginationParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? orderIds,
    List<int>? statusIds,
    List<int>? productIds,
    List<int>? variantIds,
    List<int>? fromCityIds,
    List<int>? toCityIds,
    double? totalPriceFrom,
    double? totalPriceTo,
    int? qtyFrom,
    int? qtyTo,
    bool? isActive,
    bool? isCanceled,
    bool? isPaid,
    bool? isRefunded,
    DateTime? deliveryFrom,
    DateTime? deliveryTo,
    DateTime? createdFrom,
    DateTime? createdTo,
    bool? isShowDeleted,
  }) {
    return ProductOrderItemPaginationParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      orderIds: orderIds ?? this.orderIds,
      statusIds: statusIds ?? this.statusIds,
      productIds: productIds ?? this.productIds,
      variantIds: variantIds ?? this.variantIds,
      fromCityIds: fromCityIds ?? this.fromCityIds,
      toCityIds: toCityIds ?? this.toCityIds,
      totalPriceFrom: totalPriceFrom ?? this.totalPriceFrom,
      totalPriceTo: totalPriceTo ?? this.totalPriceTo,
      qtyFrom: qtyFrom ?? this.qtyFrom,
      qtyTo: qtyTo ?? this.qtyTo,
      isActive: isActive ?? this.isActive,
      isCanceled: isCanceled ?? this.isCanceled,
      isPaid: isPaid ?? this.isPaid,
      isRefunded: isRefunded ?? this.isRefunded,
      deliveryFrom: deliveryFrom ?? this.deliveryFrom,
      deliveryTo: deliveryTo ?? this.deliveryTo,
      createdFrom: createdFrom ?? this.createdFrom,
      createdTo: createdTo ?? this.createdTo,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
