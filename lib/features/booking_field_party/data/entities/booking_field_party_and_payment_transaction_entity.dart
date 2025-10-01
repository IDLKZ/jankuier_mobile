import 'package:equatable/equatable.dart';

import '../../../ticket/data/entities/ticket_order/payment_transaction_entity.dart';
import 'booking_field_party_request_entity.dart';

// Entity для связи бронирования площадки и платежной транзакции (из BookingFieldPartyAndPaymentTransactionWithRelationsRDTO)
class BookingFieldPartyAndPaymentTransactionEntity extends Equatable {
  final int id;
  final int requestId;
  final int paymentTransactionId;
  final bool isActive;
  final bool isPrimary;
  final String linkType;
  final String? linkReason;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final BookingFieldPartyRequestEntity? bookingRequest;
  final PaymentTransactionEntity? paymentTransaction;

  const BookingFieldPartyAndPaymentTransactionEntity({
    required this.id,
    required this.requestId,
    required this.paymentTransactionId,
    required this.isActive,
    required this.isPrimary,
    required this.linkType,
    this.linkReason,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.bookingRequest,
    this.paymentTransaction,
  });

  factory BookingFieldPartyAndPaymentTransactionEntity.fromJson(
      Map<String, dynamic> json) {
    return BookingFieldPartyAndPaymentTransactionEntity(
      id: json['id'] ?? 0,
      requestId: json['request_id'] ?? 0,
      paymentTransactionId: json['payment_transaction_id'] ?? 0,
      isActive: json['is_active'] ?? true,
      isPrimary: json['is_primary'] ?? false,
      linkType: json['link_type'] ?? '',
      linkReason: json['link_reason'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      bookingRequest: json['booking_request'] != null
          ? BookingFieldPartyRequestEntity.fromJson(json['booking_request'])
          : null,
      paymentTransaction: json['payment_transaction'] != null
          ? PaymentTransactionEntity.fromJson(json['payment_transaction'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        requestId,
        paymentTransactionId,
        isActive,
        isPrimary,
        linkType,
        linkReason,
        createdAt,
        updatedAt,
        deletedAt,
        bookingRequest,
        paymentTransaction,
      ];
}

// Parameter для создания связи
class BookingFieldPartyAndPaymentTransactionCreateParameter {
  final int requestId;
  final int paymentTransactionId;
  final bool isActive;
  final bool isPrimary;
  final String linkType;
  final String? linkReason;

  const BookingFieldPartyAndPaymentTransactionCreateParameter({
    required this.requestId,
    required this.paymentTransactionId,
    this.isActive = true,
    this.isPrimary = false,
    required this.linkType,
    this.linkReason,
  });

  Map<String, dynamic> toJson() {
    return {
      'request_id': requestId,
      'payment_transaction_id': paymentTransactionId,
      'is_active': isActive,
      'is_primary': isPrimary,
      'link_type': linkType,
      if (linkReason != null) 'link_reason': linkReason,
    };
  }

  BookingFieldPartyAndPaymentTransactionCreateParameter copyWith({
    int? requestId,
    int? paymentTransactionId,
    bool? isActive,
    bool? isPrimary,
    String? linkType,
    String? linkReason,
  }) {
    return BookingFieldPartyAndPaymentTransactionCreateParameter(
      requestId: requestId ?? this.requestId,
      paymentTransactionId: paymentTransactionId ?? this.paymentTransactionId,
      isActive: isActive ?? this.isActive,
      isPrimary: isPrimary ?? this.isPrimary,
      linkType: linkType ?? this.linkType,
      linkReason: linkReason ?? this.linkReason,
    );
  }
}

// Список Entity
class BookingFieldPartyAndPaymentTransactionListEntity {
  static List<BookingFieldPartyAndPaymentTransactionEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) =>
            BookingFieldPartyAndPaymentTransactionEntity.fromJson(json))
        .toList();
  }
}
