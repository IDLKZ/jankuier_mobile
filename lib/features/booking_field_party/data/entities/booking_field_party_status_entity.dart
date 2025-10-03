import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/core/mixins/localized_title_mixin.dart';

// Entity для статуса бронирования площадки (из BookingFieldPartyStatusWithRelationsRDTO)
class BookingFieldPartyStatusEntity extends Equatable
    with LocalizedTitleEntity {
  final int id;
  final int? previousId;
  final int? nextId;
  final String value;
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
  final BookingFieldPartyStatusEntity? previousStatus;
  final BookingFieldPartyStatusEntity? nextStatus;

  const BookingFieldPartyStatusEntity({
    required this.id,
    this.previousId,
    this.nextId,
    required this.value,
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

  factory BookingFieldPartyStatusEntity.fromJson(Map<String, dynamic> json) {
    return BookingFieldPartyStatusEntity(
      id: json['id'] ?? 0,
      previousId: json['previous_id'],
      nextId: json['next_id'],
      value: json['value'] ?? '',
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
          ? BookingFieldPartyStatusEntity.fromJson(json['previous_status'])
          : null,
      nextStatus: json['next_status'] != null
          ? BookingFieldPartyStatusEntity.fromJson(json['next_status'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        previousId,
        nextId,
        value,
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
class BookingFieldPartyStatusListEntity {
  static List<BookingFieldPartyStatusEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => BookingFieldPartyStatusEntity.fromJson(json))
        .toList();
  }
}
