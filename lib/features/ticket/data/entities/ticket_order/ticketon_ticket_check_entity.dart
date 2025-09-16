import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';

class TicketonTicketCheckSeatEntity extends Equatable {
  final String? id;
  final String? row;
  final String? num;

  const TicketonTicketCheckSeatEntity({
    this.id,
    this.row,
    this.num,
  });

  factory TicketonTicketCheckSeatEntity.fromJson(Map<String, dynamic> json) {
    return TicketonTicketCheckSeatEntity(
      id: json['id'],
      row: json['row'],
      num: json['num'],
    );
  }

  @override
  List<Object?> get props => [id, row, num];
}

class TicketonTicketCheckResponseEntity extends Equatable {
  final String? ticket;
  final TicketonTicketCheckSeatEntity? seat;
  final String? hall;
  final String? cost;
  final String? commission;
  final String? code;
  final String? type;
  final String? barcode;
  final String? qr;

  const TicketonTicketCheckResponseEntity({
    this.ticket,
    this.seat,
    this.hall,
    this.cost,
    this.commission,
    this.code,
    this.type,
    this.barcode,
    this.qr,
  });

  factory TicketonTicketCheckResponseEntity.fromJson(
      Map<String, dynamic> json) {
    return TicketonTicketCheckResponseEntity(
      ticket: json['ticket'],
      seat: json['seat'] != null
          ? TicketonTicketCheckSeatEntity.fromJson(json['seat'])
          : null,
      hall: json['hall'],
      cost: json['cost'],
      commission: json['commission'],
      code: json['code'],
      type: json['type'],
      barcode: json['barcode'],
      qr: json['qr'],
    );
  }

  @override
  List<Object?> get props => [
        ticket,
        seat,
        hall,
        cost,
        commission,
        code,
        type,
        barcode,
        qr,
      ];
}

class TicketonTicketCheckCommonResponseEntity extends Equatable {
  final TicketonOrderEntity? ticketonOrder;
  final TicketonTicketCheckResponseEntity? ticketCheck;

  const TicketonTicketCheckCommonResponseEntity({
    this.ticketonOrder,
    this.ticketCheck,
  });

  factory TicketonTicketCheckCommonResponseEntity.fromJson(
      Map<String, dynamic> json) {
    return TicketonTicketCheckCommonResponseEntity(
      ticketonOrder: json['ticketon_order'] != null
          ? TicketonOrderEntity.fromJson(json['ticketon_order'])
          : null,
      ticketCheck: json['ticket_check'] != null
          ? TicketonTicketCheckResponseEntity.fromJson(json['ticket_check'])
          : null,
    );
  }

  @override
  List<Object?> get props => [ticketonOrder, ticketCheck];
}
