typedef MultiDataMap = Map<String, List<String>>;

class BookingFieldPartyRequestPaginationParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? userIds;
  final List<int>? statusIds;
  final List<int>? fieldIds;
  final List<int>? fieldPartyIds;
  final List<int>? paymentTransactionIds;
  final bool? isActive;
  final bool? isCanceled;
  final bool? isPaid;
  final bool? isRefunded;
  final bool? isShowDeleted;

  const BookingFieldPartyRequestPaginationParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.userIds,
    this.statusIds,
    this.fieldIds,
    this.fieldPartyIds,
    this.paymentTransactionIds,
    this.isActive,
    this.isCanceled,
    this.isPaid,
    this.isRefunded,
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
    put("is_active", isActive);
    put("is_canceled", isCanceled);
    put("is_paid", isPaid);
    put("is_refunded", isRefunded);
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
    put("is_active", isActive);
    put("is_canceled", isCanceled);
    put("is_paid", isPaid);
    put("is_refunded", isRefunded);
    put("is_show_deleted", isShowDeleted);

    putList("user_ids", userIds);
    putList("status_ids", statusIds);
    putList("field_ids", fieldIds);
    putList("field_party_ids", fieldPartyIds);
    putList("payment_transaction_ids", paymentTransactionIds);

    return map;
  }

  BookingFieldPartyRequestPaginationParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? userIds,
    List<int>? statusIds,
    List<int>? fieldIds,
    List<int>? fieldPartyIds,
    List<int>? paymentTransactionIds,
    bool? isActive,
    bool? isCanceled,
    bool? isPaid,
    bool? isRefunded,
    bool? isShowDeleted,
  }) {
    return BookingFieldPartyRequestPaginationParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      userIds: userIds ?? this.userIds,
      statusIds: statusIds ?? this.statusIds,
      fieldIds: fieldIds ?? this.fieldIds,
      fieldPartyIds: fieldPartyIds ?? this.fieldPartyIds,
      paymentTransactionIds:
          paymentTransactionIds ?? this.paymentTransactionIds,
      isActive: isActive ?? this.isActive,
      isCanceled: isCanceled ?? this.isCanceled,
      isPaid: isPaid ?? this.isPaid,
      isRefunded: isRefunded ?? this.isRefunded,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
