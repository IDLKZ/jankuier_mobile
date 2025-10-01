import 'package:equatable/equatable.dart';

import '../../../product_order/data/entities/alatau_create_response_order_entity.dart';
import '../../../ticket/data/entities/ticket_order/payment_transaction_entity.dart';
import 'booking_field_party_request_entity.dart';

// Entity для ответа создания бронирования площадки
class CreateBookingFieldPartyResponseEntity extends Equatable {
  final BookingFieldPartyRequestEntity? fieldBookingRequest;
  final PaymentTransactionEntity? paymentTransaction;
  final AlatauCreateResponseOrderEntity? order;
  final bool isSuccess;
  final String message;

  const CreateBookingFieldPartyResponseEntity({
    this.fieldBookingRequest,
    this.paymentTransaction,
    this.order,
    required this.isSuccess,
    required this.message,
  });

  factory CreateBookingFieldPartyResponseEntity.fromJson(
      Map<String, dynamic> json) {
    return CreateBookingFieldPartyResponseEntity(
      fieldBookingRequest: json['field_booking_request'] != null
          ? BookingFieldPartyRequestEntity.fromJson(
              json['field_booking_request'])
          : null,
      paymentTransaction: json['payment_transaction'] != null
          ? PaymentTransactionEntity.fromJson(json['payment_transaction'])
          : null,
      order: json['order'] != null
          ? AlatauCreateResponseOrderEntity.fromJson(json['order'])
          : null,
      isSuccess: json['is_success'] ?? false,
      message: json['message'] ?? 'Бронирование поля',
    );
  }

  @override
  List<Object?> get props => [
        fieldBookingRequest,
        paymentTransaction,
        order,
        isSuccess,
        message,
      ];
}
