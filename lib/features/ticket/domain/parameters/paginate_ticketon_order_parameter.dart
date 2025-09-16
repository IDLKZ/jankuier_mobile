typedef MultiDataMap = Map<String, List<String>>;

class PaginateTicketonOrderParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final List<int>? userIds;
  final List<int>? statusIds;
  final List<int>? paymentTransactionIds;
  final String? lang;
  final String? currency;
  final bool? isActive;
  final bool? isPaid;
  final bool? isCanceled;
  final bool? isShowDeleted;

  const PaginateTicketonOrderParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.userIds,
    this.statusIds,
    this.paymentTransactionIds,
    this.lang,
    this.currency,
    this.isActive,
    this.isPaid,
    this.isCanceled,
    this.isShowDeleted = false,
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
    put("lang", lang);
    put("currency", currency);
    put("is_active", isActive);
    put("is_paid", isPaid);
    put("is_canceled", isCanceled);
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
    put("lang", lang);
    put("currency", currency);
    put("is_active", isActive);
    put("is_paid", isPaid);
    put("is_canceled", isCanceled);
    put("is_show_deleted", isShowDeleted);

    putList("user_ids", userIds);
    putList("status_ids", statusIds);
    putList("payment_transaction_ids", paymentTransactionIds);

    return map;
  }

  PaginateTicketonOrderParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    List<int>? userIds,
    List<int>? statusIds,
    List<int>? paymentTransactionIds,
    String? lang,
    String? currency,
    bool? isActive,
    bool? isPaid,
    bool? isCanceled,
    bool? isShowDeleted,
  }) {
    return PaginateTicketonOrderParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      userIds: userIds ?? this.userIds,
      statusIds: statusIds ?? this.statusIds,
      paymentTransactionIds:
          paymentTransactionIds ?? this.paymentTransactionIds,
      lang: lang ?? this.lang,
      currency: currency ?? this.currency,
      isActive: isActive ?? this.isActive,
      isPaid: isPaid ?? this.isPaid,
      isCanceled: isCanceled ?? this.isCanceled,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
