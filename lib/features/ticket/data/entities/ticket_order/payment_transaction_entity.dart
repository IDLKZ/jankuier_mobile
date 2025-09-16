import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/payment_transaction_status_entity.dart';

import '../../../../auth/data/entities/user_entity.dart';

class PaymentTransactionEntity extends Equatable {
  final int id;
  final int? userId;
  final int? statusId;
  final String transactionType;
  final String order;
  final String? nonce;
  final String? mpiOrder;
  final double amount;
  final String currency;
  final String merchant;
  final String? language;
  final int? clientId;
  final String desc;
  final String? descOrder;
  final String? email;
  final String? backref;
  final String? wtype;
  final String? name;
  final String? prePSign;
  final bool isActive;
  final bool isPaid;
  final bool isCanceled;
  final DateTime? expiredAt;
  final String? resCode;
  final String? resDesc;
  final String? paidPSign;
  final double? revAmount;
  final String? revDesc;
  final String? cancelPSign;
  final Map<String, dynamic>? orderFullInfo;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final UserEntity? user;
  final PaymentTransactionStatusEntity? status;

  const PaymentTransactionEntity({
    required this.id,
    this.userId,
    this.statusId,
    required this.transactionType,
    required this.order,
    this.nonce,
    this.mpiOrder,
    required this.amount,
    required this.currency,
    required this.merchant,
    this.language,
    this.clientId,
    required this.desc,
    this.descOrder,
    this.email,
    this.backref,
    this.wtype,
    this.name,
    this.prePSign,
    required this.isActive,
    required this.isPaid,
    required this.isCanceled,
    this.expiredAt,
    this.resCode,
    this.resDesc,
    this.paidPSign,
    this.revAmount,
    this.revDesc,
    this.cancelPSign,
    this.orderFullInfo,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.user,
    this.status,
  });

  factory PaymentTransactionEntity.fromJson(Map<String, dynamic> json) {
    return PaymentTransactionEntity(
      id: json['id'],
      userId: json['user_id'],
      statusId: json['status_id'],
      transactionType: json['transaction_type'],
      order: json['order'],
      nonce: json['nonce'],
      mpiOrder: json['mpi_order'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      merchant: json['merchant'],
      language: json['language'],
      clientId: json['client_id'],
      desc: json['desc'],
      descOrder: json['desc_order'],
      email: json['email'],
      backref: json['backref'],
      wtype: json['wtype'],
      name: json['name'],
      prePSign: json['pre_p_sign'],
      isActive: json['is_active'] ?? false,
      isPaid: json['is_paid'] ?? false,
      isCanceled: json['is_canceled'] ?? false,
      expiredAt: json['expired_at'] != null
          ? DateTime.parse(json['expired_at'])
          : null,
      resCode: json['res_code'],
      resDesc: json['res_desc'],
      paidPSign: json['paid_p_sign'],
      revAmount: json['rev_amount'] != null
          ? (json['rev_amount'] as num).toDouble()
          : null,
      revDesc: json['rev_desc'],
      cancelPSign: json['cancel_p_sign'],
      orderFullInfo: json['order_full_info'] != null
          ? Map<String, dynamic>.from(json['order_full_info'])
          : null,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      user: json['user'] != null ? UserEntity.fromJson(json['user']) : null,
      status: json['status'] != null
          ? PaymentTransactionStatusEntity.fromJson(json['status'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        statusId,
        transactionType,
        order,
        nonce,
        mpiOrder,
        amount,
        currency,
        merchant,
        language,
        clientId,
        desc,
        descOrder,
        email,
        backref,
        wtype,
        name,
        prePSign,
        isActive,
        isPaid,
        isCanceled,
        expiredAt,
        resCode,
        resDesc,
        paidPSign,
        revAmount,
        revDesc,
        cancelPSign,
        orderFullInfo,
        createdAt,
        updatedAt,
        deletedAt,
        user,
        status,
      ];
}

class PaymentTransactionListEntity {
  static List<PaymentTransactionEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => PaymentTransactionEntity.fromJson(json))
        .toList();
  }
}
