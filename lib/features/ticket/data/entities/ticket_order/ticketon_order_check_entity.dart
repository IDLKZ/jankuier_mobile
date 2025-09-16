import 'package:equatable/equatable.dart';
import 'package:jankuier_mobile/features/ticket/data/entities/ticket_order/ticket_order_entity.dart';

class TicketonOrderCheckTicketEntity extends Equatable {
  final String? id;
  final String? seatId;
  final String? row;
  final String? number;
  final String? level;
  final String? hallName;
  final String? cost;
  final String? commission;
  final String? type;
  final String? format;
  final String? code;
  final String? placeCode;
  final String? reservationCode;
  final String? saleTicketCode;
  final int? useReserveCode;
  final int? usePlaceCode;
  final int? useSalePlaceCode;
  final int? useExtPrefix;
  final String? barcode;
  final String? qr;

  const TicketonOrderCheckTicketEntity({
    this.id,
    this.seatId,
    this.row,
    this.number,
    this.level,
    this.hallName,
    this.cost,
    this.commission,
    this.type,
    this.format,
    this.code,
    this.placeCode,
    this.reservationCode,
    this.saleTicketCode,
    this.useReserveCode,
    this.usePlaceCode,
    this.useSalePlaceCode,
    this.useExtPrefix,
    this.barcode,
    this.qr,
  });

  factory TicketonOrderCheckTicketEntity.fromJson(Map<String, dynamic> json) {
    return TicketonOrderCheckTicketEntity(
      id: json['id'],
      seatId: json['seat_id'],
      row: json['row'],
      number: json['number'],
      level: json['level'],
      hallName: json['hall_name'],
      cost: json['cost'],
      commission: json['commission'],
      type: json['type'],
      format: json['format'],
      code: json['code'],
      placeCode: json['place_code'],
      reservationCode: json['reservation_code'],
      saleTicketCode: json['sale_ticket_code'],
      useReserveCode: json['use_reserve_code'],
      usePlaceCode: json['use_place_code'],
      useSalePlaceCode: json['use_sale_place_code'],
      useExtPrefix: json['use_ext_prefix'],
      barcode: json['barcode'],
      qr: json['qr'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        seatId,
        row,
        number,
        level,
        hallName,
        cost,
        commission,
        type,
        format,
        code,
        placeCode,
        reservationCode,
        saleTicketCode,
        useReserveCode,
        usePlaceCode,
        useSalePlaceCode,
        useExtPrefix,
        barcode,
        qr,
      ];
}

class TicketonOrderCheckSaleEntity extends Equatable {
  final String? id;
  final String? saleId;
  final String? reservationCode;
  final String? date;
  final int? price;
  final int? finalPrice;
  final String? status;
  final String? expire;
  final int? commission;

  const TicketonOrderCheckSaleEntity({
    this.id,
    this.saleId,
    this.reservationCode,
    this.date,
    this.price,
    this.finalPrice,
    this.status,
    this.expire,
    this.commission,
  });

  factory TicketonOrderCheckSaleEntity.fromJson(Map<String, dynamic> json) {
    return TicketonOrderCheckSaleEntity(
      id: json['id'],
      saleId: json['sale_id'],
      reservationCode: json['reservation_code'],
      date: json['date'],
      price: json['price'],
      finalPrice: json['final_price'],
      status: json['status'],
      expire: json['expire'],
      commission: json['commission'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        saleId,
        reservationCode,
        date,
        price,
        finalPrice,
        status,
        expire,
        commission,
      ];
}

class TicketonOrderCheckShowEntity extends Equatable {
  final String? id;
  final String? date;
  final String? description;
  final String? information;
  final String? duration;
  final String? action;
  final String? place;
  final String? address;
  final String? hall;
  final String? type;

  const TicketonOrderCheckShowEntity({
    this.id,
    this.date,
    this.description,
    this.information,
    this.duration,
    this.action,
    this.place,
    this.address,
    this.hall,
    this.type,
  });

  factory TicketonOrderCheckShowEntity.fromJson(Map<String, dynamic> json) {
    return TicketonOrderCheckShowEntity(
      id: json['id'],
      date: json['date'],
      description: json['description'],
      information: json['information'],
      duration: json['duration'],
      action: json['action'],
      place: json['place'],
      address: json['address'],
      hall: json['hall'],
      type: json['type'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        date,
        description,
        information,
        duration,
        action,
        place,
        address,
        hall,
        type,
      ];
}

class TicketonOrderCheckResponseEntity extends Equatable {
  final Map<String, TicketonOrderCheckTicketEntity>? tickets;
  final TicketonOrderCheckSaleEntity? sale;
  final TicketonOrderCheckShowEntity? show;

  const TicketonOrderCheckResponseEntity({
    this.tickets,
    this.sale,
    this.show,
  });

  factory TicketonOrderCheckResponseEntity.fromJson(Map<String, dynamic> json) {
    Map<String, TicketonOrderCheckTicketEntity>? tickets;
    if (json['tickets'] != null) {
      tickets = {};
      json['tickets'].forEach((key, value) {
        tickets![key] = TicketonOrderCheckTicketEntity.fromJson(value);
      });
    }

    return TicketonOrderCheckResponseEntity(
      tickets: tickets,
      sale: json['sale'] != null
          ? TicketonOrderCheckSaleEntity.fromJson(json['sale'])
          : null,
      show: json['show'] != null
          ? TicketonOrderCheckShowEntity.fromJson(json['show'])
          : null,
    );
  }

  @override
  List<Object?> get props => [tickets, sale, show];
}

class TicketonOrderCheckStatus {
  static const String expiringNotConfirmed = "1";
  static const String confirmed = "2";
  static const String cancelledExpiring = "3";
  static const String refundConfirmed = "4";
}

class TicketonOrderCheckCommonResponseEntity extends Equatable {
  final TicketonOrderEntity? ticketonOrder;
  final TicketonOrderCheckResponseEntity? orderCheck;

  const TicketonOrderCheckCommonResponseEntity({
    this.ticketonOrder,
    this.orderCheck,
  });

  factory TicketonOrderCheckCommonResponseEntity.fromJson(
      Map<String, dynamic> json) {
    return TicketonOrderCheckCommonResponseEntity(
      ticketonOrder: json['ticketon_order'] != null
          ? TicketonOrderEntity.fromJson(json['ticketon_order'])
          : null,
      orderCheck: json['order_check'] != null
          ? TicketonOrderCheckResponseEntity.fromJson(json['order_check'])
          : null,
    );
  }

  @override
  List<Object?> get props => [ticketonOrder, orderCheck];
}
