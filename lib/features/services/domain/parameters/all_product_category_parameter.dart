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
    return {
      "search": search,
      "order_by": orderBy ?? "updated_at",
      "order_direction": orderDirection ?? "desc",
      "is_active": isActive ?? true,
      "isShowDeleted": isActive ?? false,
    };
  }
}
