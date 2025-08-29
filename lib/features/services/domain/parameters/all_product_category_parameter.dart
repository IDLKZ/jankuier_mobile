import '../../../../core/utils/typedef.dart';

class AllProductCategoryParameter {
  final String? search;
  final String? orderBy;
  final String? orderDirection;
  final bool isActive;
  final bool isShowDeleted;

  const AllProductCategoryParameter({
    this.search,
    this.orderBy,
    this.orderDirection,
    this.isActive = true,
    this.isShowDeleted = false,
  });

  DataMap toMap() {
    final map = <String, dynamic>{};

    if (search != null) map["search"] = search;
    if (orderBy != null) {
      map["order_by"] = orderBy;
    } else {
      map["order_by"] = "updated_at";
    }

    if (orderDirection != null) {
      map["order_direction"] = orderDirection;
    } else {
      map["order_direction"] = "desc";
    }

    map["is_active"] = isActive;
    map["is_show_deleted"] = isShowDeleted;

    return map;
  }
}
