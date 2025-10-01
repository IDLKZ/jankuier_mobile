// Entity для ответа создания заказа Alatau
import 'package:equatable/equatable.dart';

class AlatauCreateResponseOrderEntity extends Equatable {
  final String? order;
  final String? amount;
  final String? currency;
  final String? merchant;
  final String? terminal;
  final String? desc;
  final String? descOrder;
  final String? email;
  final String? wtype;
  final String? name;
  final String? nonce;
  final String? clientId;
  final String? backref;
  final String? ucafFlag;
  final String? ucafAuthenticationData;
  final String? pSign;

  const AlatauCreateResponseOrderEntity({
    this.order,
    this.amount,
    this.currency,
    this.merchant,
    this.terminal,
    this.desc,
    this.descOrder,
    this.email,
    this.wtype,
    this.name,
    this.nonce,
    this.clientId,
    this.backref,
    this.ucafFlag,
    this.ucafAuthenticationData,
    this.pSign,
  });

  factory AlatauCreateResponseOrderEntity.fromJson(Map<String, dynamic> json) {
    return AlatauCreateResponseOrderEntity(
      order: json['ORDER'],
      amount: json['AMOUNT']?.toString(),
      currency: json['CURRENCY'],
      merchant: json['MERCHANT'],
      terminal: json['TERMINAL'],
      desc: json['DESC'],
      descOrder: json['DESC_ORDER'],
      email: json['EMAIL'],
      wtype: json['WTYPE'],
      name: json['NAME'],
      nonce: json['NONCE'],
      clientId: json['CLIENT_ID']?.toString(),
      backref: json['BACKREF'],
      ucafFlag: json['Ucaf_Flag'],
      ucafAuthenticationData: json['Ucaf_Authentication_Data'],
      pSign: json['P_SIGN'],
    );
  }

  @override
  List<Object?> get props => [
        order,
        amount,
        currency,
        merchant,
        terminal,
        desc,
        descOrder,
        email,
        wtype,
        name,
        nonce,
        clientId,
        backref,
        ucafFlag,
        ucafAuthenticationData,
        pSign,
      ];
}
