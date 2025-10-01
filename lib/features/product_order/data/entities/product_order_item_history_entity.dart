import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_entity.dart';
import 'package:jankuier_mobile/features/product_order/data/entities/product_order_item_status_entity.dart';

import '../../../auth/data/entities/user_entity.dart';

// Entity для истории элемента заказа (из ProductOrderItemHistoryWithRelationsRDTO)
class ProductOrderItemHistoryEntity extends Equatable {
  final int id;
  final int orderItemId;
  final int? statusId;
  final int? responsibleUserId;
  final String? messageRu;
  final String? messageKk;
  final String? messageEn;
  final bool? isPassed;
  final String? cancelReason;
  final DateTime? takenAt;
  final DateTime? passedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final ProductOrderItemEntity? orderItem;
  final ProductOrderItemStatusEntity? status;
  final UserEntity? responsibleUser;

  const ProductOrderItemHistoryEntity({
    required this.id,
    required this.orderItemId,
    this.statusId,
    this.responsibleUserId,
    this.messageRu,
    this.messageKk,
    this.messageEn,
    this.isPassed,
    this.cancelReason,
    this.takenAt,
    this.passedAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.orderItem,
    this.status,
    this.responsibleUser,
  });

  factory ProductOrderItemHistoryEntity.fromJson(Map<String, dynamic> json) {
    return ProductOrderItemHistoryEntity(
      id: json['id'] ?? 0,
      orderItemId: json['order_item_id'] ?? 0,
      statusId: json['status_id'],
      responsibleUserId: json['responsible_user_id'],
      messageRu: json['message_ru'],
      messageKk: json['message_kk'],
      messageEn: json['message_en'],
      isPassed: json['is_passed'],
      cancelReason: json['cancel_reason'],
      takenAt:
          json['taken_at'] != null ? DateTime.tryParse(json['taken_at']) : null,
      passedAt: json['passed_at'] != null
          ? DateTime.tryParse(json['passed_at'])
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      orderItem: json['order_item'] != null
          ? ProductOrderItemEntity.fromJson(json['order_item'])
          : null,
      status: json['status'] != null
          ? ProductOrderItemStatusEntity.fromJson(json['status'])
          : null,
      responsibleUser: json['responsible_user'] != null
          ? UserEntity.fromJson(json['responsible_user'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        orderItemId,
        statusId,
        responsibleUserId,
        messageRu,
        messageKk,
        messageEn,
        isPassed,
        cancelReason,
        takenAt,
        passedAt,
        createdAt,
        updatedAt,
        deletedAt,
        orderItem,
        status,
        responsibleUser,
      ];
}

// Parameter для создания записи истории
class ProductOrderItemHistoryCreateParameter {
  final int orderItemId;
  final int? statusId;
  final int? responsibleUserId;
  final String? messageRu;
  final String? messageKk;
  final String? messageEn;
  final bool? isPassed;
  final String? cancelReason;
  final DateTime? takenAt;
  final DateTime? passedAt;

  const ProductOrderItemHistoryCreateParameter({
    required this.orderItemId,
    this.statusId,
    this.responsibleUserId,
    this.messageRu,
    this.messageKk,
    this.messageEn,
    this.isPassed,
    this.cancelReason,
    this.takenAt,
    this.passedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_item_id': orderItemId,
      if (statusId != null) 'status_id': statusId,
      if (responsibleUserId != null) 'responsible_user_id': responsibleUserId,
      if (messageRu != null) 'message_ru': messageRu,
      if (messageKk != null) 'message_kk': messageKk,
      if (messageEn != null) 'message_en': messageEn,
      if (isPassed != null) 'is_passed': isPassed,
      if (cancelReason != null) 'cancel_reason': cancelReason,
      if (takenAt != null) 'taken_at': takenAt!.toIso8601String(),
      if (passedAt != null) 'passed_at': passedAt!.toIso8601String(),
    };
  }

  ProductOrderItemHistoryCreateParameter copyWith({
    int? orderItemId,
    int? statusId,
    int? responsibleUserId,
    String? messageRu,
    String? messageKk,
    String? messageEn,
    bool? isPassed,
    String? cancelReason,
    DateTime? takenAt,
    DateTime? passedAt,
  }) {
    return ProductOrderItemHistoryCreateParameter(
      orderItemId: orderItemId ?? this.orderItemId,
      statusId: statusId ?? this.statusId,
      responsibleUserId: responsibleUserId ?? this.responsibleUserId,
      messageRu: messageRu ?? this.messageRu,
      messageKk: messageKk ?? this.messageKk,
      messageEn: messageEn ?? this.messageEn,
      isPassed: isPassed ?? this.isPassed,
      cancelReason: cancelReason ?? this.cancelReason,
      takenAt: takenAt ?? this.takenAt,
      passedAt: passedAt ?? this.passedAt,
    );
  }
}

// Список Entity
class ProductOrderItemHistoryListEntity {
  static List<ProductOrderItemHistoryEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => ProductOrderItemHistoryEntity.fromJson(json))
        .toList();
  }
}
