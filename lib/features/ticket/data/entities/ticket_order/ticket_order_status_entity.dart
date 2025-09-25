import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';

class TicketonOrderStatusEntity extends Equatable with LocalizedTitleEntity {
  final int id;
  final int? previousId;
  final int? nextId;
  @override
  final String titleRu;
  @override
  final String? titleKk;
  @override
  final String? titleEn;
  final bool isFirst;
  final bool isActive;
  final bool isLast;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final TicketonOrderStatusEntity? previousStatus;
  final TicketonOrderStatusEntity? nextStatus;

  const TicketonOrderStatusEntity({
    required this.id,
    this.previousId,
    this.nextId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.isFirst,
    required this.isActive,
    required this.isLast,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.previousStatus,
    this.nextStatus,
  });

  factory TicketonOrderStatusEntity.fromJson(Map<String, dynamic> json) {
    return TicketonOrderStatusEntity(
      id: json['id'],
      previousId: json['previous_id'],
      nextId: json['next_id'],
      titleRu: json['title_ru'],
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      isFirst: json['is_first'] ?? false,
      isActive: json['is_active'] ?? true,
      isLast: json['is_last'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      previousStatus: json['previous_status'] != null
          ? TicketonOrderStatusEntity.fromJson(json['previous_status'])
          : null,
      nextStatus: json['next_status'] != null
          ? TicketonOrderStatusEntity.fromJson(json['next_status'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        previousId,
        nextId,
        titleRu,
        titleKk,
        titleEn,
        isFirst,
        isActive,
        isLast,
        createdAt,
        updatedAt,
        deletedAt,
        previousStatus,
        nextStatus,
      ];
}

class TicketonOrderStatusListEntity {
  static List<TicketonOrderStatusEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => TicketonOrderStatusEntity.fromJson(json))
        .toList();
  }
}
