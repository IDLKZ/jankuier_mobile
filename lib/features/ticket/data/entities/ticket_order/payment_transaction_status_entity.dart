import 'package:equatable/equatable.dart';

class PaymentTransactionStatusEntity extends Equatable {
  final int id;
  final int? previousId;
  final int? nextId;
  final String titleRu;
  final String? titleKk;
  final String? titleEn;
  final bool isFirst;
  final bool isActive;
  final bool isLast;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final PaymentTransactionStatusEntity? previousStatus;
  final PaymentTransactionStatusEntity? nextStatus;

  const PaymentTransactionStatusEntity({
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

  factory PaymentTransactionStatusEntity.fromJson(Map<String, dynamic> json) {
    return PaymentTransactionStatusEntity(
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
          ? PaymentTransactionStatusEntity.fromJson(json['previous_status'])
          : null,
      nextStatus: json['next_status'] != null
          ? PaymentTransactionStatusEntity.fromJson(json['next_status'])
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

class PaymentTransactionStatusListEntity {
  static List<PaymentTransactionStatusEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => PaymentTransactionStatusEntity.fromJson(json))
        .toList();
  }
}
