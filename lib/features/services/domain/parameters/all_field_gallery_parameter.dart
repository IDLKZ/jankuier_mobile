import 'package:jankuier_mobile/core/utils/typedef.dart';

class AllFieldGalleryFilter {
  final String? orderBy;
  final String? orderDirection;

  final List<int>? fieldIds;
  final List<int>? partyIds;
  final List<int>? fileIds;

  final bool? isShowDeleted;

  const AllFieldGalleryFilter({
    this.orderBy = "updated_at",
    this.orderDirection = "desc",
    this.fieldIds,
    this.partyIds,
    this.fileIds,
    this.isShowDeleted,
  });

  /// Простая сериализация
  Map<String, String> toFlatMap() {
    final map = <String, String>{};

    void put<T>(String key, T? value) {
      if (value != null) map[key] = value.toString();
    }

    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_show_deleted", isShowDeleted);

    return map;
  }

  /// Поддержка массивов (query типа ?field_ids=1&field_ids=2)
  DataMap toQueryParameters() {
    final map = <String, List<String>>{};

    void put(String key, dynamic value) {
      if (value != null) map[key] = [value.toString()];
    }

    void putList(String key, List<int>? values) {
      if (values != null && values.isNotEmpty) {
        map[key] = values.map((e) => e.toString()).toList();
      }
    }

    put("order_by", orderBy);
    put("order_direction", orderDirection);
    put("is_show_deleted", isShowDeleted);

    putList("field_ids", fieldIds);
    putList("party_ids", partyIds);
    putList("file_ids", fileIds);

    return map;
  }

  AllFieldGalleryFilter copyWith({
    String? orderBy,
    String? orderDirection,
    List<int>? fieldIds,
    List<int>? partyIds,
    List<int>? fileIds,
    bool? isShowDeleted,
  }) {
    return AllFieldGalleryFilter(
      orderBy: orderBy ?? this.orderBy,
      orderDirection: orderDirection ?? this.orderDirection,
      fieldIds: fieldIds ?? this.fieldIds,
      partyIds: partyIds ?? this.partyIds,
      fileIds: fileIds ?? this.fileIds,
      isShowDeleted: isShowDeleted ?? this.isShowDeleted,
    );
  }
}
