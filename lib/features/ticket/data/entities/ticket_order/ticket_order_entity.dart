import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/payment_transaction_entity.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_status_entity.dart';

import '../../../../auth/data/entities/user_entity.dart';

class TicketItemEntity extends Equatable {
  final String? id;
  final String? com;
  final String? num;
  final String? row;
  final String? code;
  final String? cost;
  final String? level;

  const TicketItemEntity({
    this.id,
    this.com,
    this.num,
    this.row,
    this.code,
    this.cost,
    this.level,
  });

  factory TicketItemEntity.fromJson(Map<String, dynamic> json) {
    return TicketItemEntity(
      id: json['id'],
      com: json['com'],
      num: json['num'],
      row: json['row'],
      code: json['code'],
      cost: json['cost'],
      level: json['level'],
    );
  }

  @override
  List<Object?> get props => [id, com, num, row, code, cost, level];
}

class TicketItemListEntity {
  static List<TicketItemEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TicketItemEntity.fromJson(json)).toList();
  }
}

class TicketonOrderEntity extends Equatable {
  final int id;
  final int? statusId;
  final int? userId;
  final int? paymentTransactionId;
  final String show;
  final List<String>? seats;
  final String lang;
  final String? preSale;
  final String? sale;
  final String? reservationId;
  final double? price;
  final int? expire;
  final DateTime? expiredAt;
  final double? sum;
  final String? currency;
  final List<TicketItemEntity>? preTickets;
  final List<TicketItemEntity>? tickets;
  final String? saleSecuryToken;
  final bool isActive;
  final bool isPaid;
  final bool isCanceled;
  final String? cancelReason;
  final String? email;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final TicketonOrderStatusEntity? status;
  final UserEntity? user;
  final PaymentTransactionEntity? paymentTransaction;

  const TicketonOrderEntity({
    required this.id,
    this.statusId,
    this.userId,
    this.paymentTransactionId,
    required this.show,
    this.seats,
    required this.lang,
    this.preSale,
    this.sale,
    this.reservationId,
    this.price,
    this.expire,
    this.expiredAt,
    this.sum,
    this.currency,
    this.preTickets,
    this.tickets,
    this.saleSecuryToken,
    required this.isActive,
    required this.isPaid,
    required this.isCanceled,
    this.cancelReason,
    this.email,
    this.phone,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.status,
    this.user,
    this.paymentTransaction,
  });

  factory TicketonOrderEntity.fromJson(Map<String, dynamic> json) {
    return TicketonOrderEntity(
      id: json['id'],
      statusId: json['status_id'],
      userId: json['user_id'],
      paymentTransactionId: json['payment_transaction_id'],
      show: json['show'],
      seats: json['seats'] != null ? List<String>.from(json['seats']) : null,
      lang: json['lang'],
      preSale: json['pre_sale'],
      sale: json['sale'],
      reservationId: json['reservation_id'],
      price: json['price'] != null ? (json['price'] as num).toDouble() : null,
      expire: json['expire'],
      expiredAt: json['expired_at'] != null
          ? DateTime.parse(json['expired_at'])
          : null,
      sum: json['sum'] != null ? (json['sum'] as num).toDouble() : null,
      currency: json['currency'],
      preTickets: json['pre_tickets'] != null
          ? TicketItemListEntity.fromJsonList(json["pre_tickets"])
          : null,
      tickets: json['tickets'] != null
          ? TicketItemListEntity.fromJsonList(json["tickets"])
          : null,
      saleSecuryToken: json['sale_secury_token'],
      isActive: json['is_active'] ?? false,
      isPaid: json['is_paid'] ?? false,
      isCanceled: json['is_canceled'] ?? false,
      cancelReason: json['cancel_reason'],
      email: json['email'],
      phone: json['phone'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      status: json['status'] != null
          ? TicketonOrderStatusEntity.fromJson(json['status'])
          : null,
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
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
        paymentTransactionId,
        show,
        seats,
        lang,
        preSale,
        sale,
        reservationId,
        price,
        expire,
        expiredAt,
        sum,
        currency,
        preTickets,
        tickets,
        saleSecuryToken,
        isActive,
        isPaid,
        isCanceled,
        cancelReason,
        email,
        phone,
        createdAt,
        updatedAt,
        deletedAt,
        status,
        user,
        paymentTransaction,
      ];
}

class TicketonOrderListEntity {
  static List<TicketonOrderEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => TicketonOrderEntity.fromJson(json)).toList();
  }
}
