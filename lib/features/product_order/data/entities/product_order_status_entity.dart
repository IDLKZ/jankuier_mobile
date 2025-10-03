import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';

// Entity для статуса заказа продукта (из ProductOrderStatusWithRelationsRDTO)
class ProductOrderStatusEntity extends Equatable with LocalizedTitleEntity {
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
  final List<String>? previousAllowedValues;
  final List<String>? nextAllowedValues;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ProductOrderStatusEntity? previousStatus;
  final ProductOrderStatusEntity? nextStatus;

  const ProductOrderStatusEntity({
    required this.id,
    this.previousId,
    this.nextId,
    required this.titleRu,
    this.titleKk,
    this.titleEn,
    required this.isFirst,
    required this.isActive,
    required this.isLast,
    this.previousAllowedValues,
    this.nextAllowedValues,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.previousStatus,
    this.nextStatus,
  });

  factory ProductOrderStatusEntity.fromJson(Map<String, dynamic> json) {
    return ProductOrderStatusEntity(
      id: json['id'] ?? 0,
      previousId: json['previous_id'],
      nextId: json['next_id'],
      titleRu: json['title_ru'] ?? '',
      titleKk: json['title_kk'],
      titleEn: json['title_en'],
      isFirst: json['is_first'] ?? false,
      isActive: json['is_active'] ?? true,
      isLast: json['is_last'] ?? false,
      previousAllowedValues: json['previous_allowed_values'] != null
          ? List<String>.from(json['previous_allowed_values'])
          : null,
      nextAllowedValues: json['next_allowed_values'] != null
          ? List<String>.from(json['next_allowed_values'])
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      previousStatus: json['previous_status'] != null
          ? ProductOrderStatusEntity.fromJson(json['previous_status'])
          : null,
      nextStatus: json['next_status'] != null
          ? ProductOrderStatusEntity.fromJson(json['next_status'])
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
        previousAllowedValues,
        nextAllowedValues,
        createdAt,
        updatedAt,
        deletedAt,
        previousStatus,
        nextStatus,
      ];
}

// Список Entity
class ProductOrderStatusListEntity {
  static List<ProductOrderStatusEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductOrderStatusEntity.fromJson(json))
        .toList();
  }
}
