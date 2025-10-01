import 'package:equatable/equatable.dart';
import '../../../auth/data/entities/user_entity.dart';
import '../../../services/data/entities/field/field_entity.dart';
import '../../../services/data/entities/field/field_party_entity.dart';
import '../../../ticket/data/entities/ticket_order/payment_transaction_entity.dart';
import 'booking_field_party_status_entity.dart';

// Entity для запроса бронирования площадки (из BookingFieldPartyRequestWithRelationsRDTO)
class BookingFieldPartyRequestEntity extends Equatable {
  final int id;
  final int? statusId;
  final int userId;
  final int? fieldId;
  final int? fieldPartyId;
  final int? paymentTransactionId;
  final double totalPrice;
  final bool isActive;
  final bool isCanceled;
  final bool isPaid;
  final bool isRefunded;
  final String? cancelReason;
  final String? cancelRefundReason;
  final String? email;
  final String? phone;
  final DateTime? paidUntil;
  final DateTime? paidAt;
  final String? paidOrder;
  final DateTime startAt;
  final DateTime endAt;
  final DateTime? rescheduleStartAt;
  final DateTime? rescheduleEndAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final BookingFieldPartyStatusEntity? status;
  final UserEntity? user;
  final FieldEntity? field;
  final FieldPartyEntity? fieldParty;
  final PaymentTransactionEntity? paymentTransaction;

  const BookingFieldPartyRequestEntity({
    required this.id,
    this.statusId,
    required this.userId,
    this.fieldId,
    this.fieldPartyId,
    this.paymentTransactionId,
    required this.totalPrice,
    required this.isActive,
    required this.isCanceled,
    required this.isPaid,
    required this.isRefunded,
    this.cancelReason,
    this.cancelRefundReason,
    this.email,
    this.phone,
    this.paidUntil,
    this.paidAt,
    this.paidOrder,
    required this.startAt,
    required this.endAt,
    this.rescheduleStartAt,
    this.rescheduleEndAt,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.status,
    this.user,
    this.field,
    this.fieldParty,
    this.paymentTransaction,
  });

  factory BookingFieldPartyRequestEntity.fromJson(Map<String, dynamic> json) {
    return BookingFieldPartyRequestEntity(
      id: json['id'] ?? 0,
      statusId: json['status_id'],
      userId: json['user_id'] ?? 0,
      fieldId: json['field_id'],
      fieldPartyId: json['field_party_id'],
      paymentTransactionId: json['payment_transaction_id'],
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      isActive: json['is_active'] ?? true,
      isCanceled: json['is_canceled'] ?? false,
      isPaid: json['is_paid'] ?? false,
      isRefunded: json['is_refunded'] ?? false,
      cancelReason: json['cancel_reason'],
      cancelRefundReason: json['cancel_refund_reason'],
      email: json['email'],
      phone: json['phone'],
      paidUntil: json['paid_until'] != null
          ? DateTime.tryParse(json['paid_until'])
          : null,
      paidAt:
          json['paid_at'] != null ? DateTime.tryParse(json['paid_at']) : null,
      paidOrder: json['paid_order'],
      startAt: DateTime.tryParse(json['start_at'] ?? '') ?? DateTime.now(),
      endAt: DateTime.tryParse(json['end_at'] ?? '') ?? DateTime.now(),
      rescheduleStartAt: json['reschedule_start_at'] != null
          ? DateTime.tryParse(json['reschedule_start_at'])
          : null,
      rescheduleEndAt: json['reschedule_end_at'] != null
          ? DateTime.tryParse(json['reschedule_end_at'])
          : null,
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at'] ?? '') ?? DateTime.now(),
      deletedAt: json['deleted_at'] != null
          ? DateTime.tryParse(json['deleted_at'])
          : null,
      status: json['status'] != null
          ? BookingFieldPartyStatusEntity.fromJson(json['status'])
          : null,
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      field: json['field'] != null ? FieldEntity.fromJson(json['field']) : null,
      fieldParty: json['field_party'] != null
          ? FieldPartyEntity.fromJson(json['field_party'])
          : null,
      paymentTransaction: json['payment_transaction'] != null
          ? PaymentTransactionEntity.fromJson(json['payment_transaction'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        statusId,
        userId,
        fieldId,
        fieldPartyId,
        paymentTransactionId,
        totalPrice,
        isActive,
        isCanceled,
        isPaid,
        isRefunded,
        cancelReason,
        cancelRefundReason,
        email,
        phone,
        paidUntil,
        paidAt,
        paidOrder,
        startAt,
        endAt,
        rescheduleStartAt,
        rescheduleEndAt,
        createdAt,
        updatedAt,
        deletedAt,
        status,
        user,
        field,
        fieldParty,
        paymentTransaction,
      ];
}

// Список Entity
class BookingFieldPartyRequestListEntity {
  static List<BookingFieldPartyRequestEntity> fromJsonList(
      List<dynamic> jsonList) {
    return jsonList
        .map((json) => BookingFieldPartyRequestEntity.fromJson(json))
        .toList();
  }
}
