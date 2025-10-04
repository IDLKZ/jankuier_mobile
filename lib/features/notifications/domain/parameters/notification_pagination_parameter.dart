typedef MultiDataMap = Map<String, List<String>>;

class NotificationPaginationParameter {
  final int? perPage;
  final int? page;
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final int? topicId;
  final int? userId;
  final bool? isActive;
  final bool? isRead;
  final int? currentUserId;
  final bool? isShowDeleted;

  const NotificationPaginationParameter({
    this.perPage = 12,
    this.page = 1,
    this.search,
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.topicId,
    this.userId,
    this.isActive,
    this.isRead,
    this.currentUserId,
    this.isShowDeleted = false,
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
    put("topic_id", topicId);
    put("user_id", userId);
    put("is_active", isActive);
    put("is_read", isRead);
    put("current_user_id", currentUserId);
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

    put("per_page", perPage);
    put("page", page);
    put("search", search);
    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("topic_id", topicId);
    put("user_id", userId);
    put("is_active", isActive);
    put("is_read", isRead);
    put("current_user_id", currentUserId);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  NotificationPaginationParameter copyWith({
    int? perPage,
    int? page,
    String? search,
    String? orderBy,
    String? orderDirection,
    int? topicId,
    int? userId,
    bool? isActive,
    bool? isRead,
    int? currentUserId,
    bool? isShowDeleted,
  }) {
    return NotificationPaginationParameter(
      perPage: perPage ?? this.perPage,
      page: page ?? this.page,
      search: search ?? this.search,
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      topicId: topicId ?? this.topicId,
      userId: userId ?? this.userId,
      isActive: isActive ?? this.isActive,
      isRead: isRead ?? this.isRead,
      currentUserId: currentUserId ?? this.currentUserId,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
