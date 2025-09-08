import 'package:equatable/equatable.dart';

class TicketonPrice extends Equatable {
  final String? type;
  final String? name;
  final int? sum;
  final List<dynamic>? discounts;
  final int? showDiscount;

  const TicketonPrice({
    this.type,
    this.name,
    this.sum,
    this.discounts,
    this.showDiscount,
  });

  factory TicketonPrice.fromJson(Map<String, dynamic> json) {
    return TicketonPrice(
      type: json['type']?.toString(),
      name: json['name'],
      sum: int.tryParse(json['sum']?.toString() ?? ''),
      discounts: json['discounts'],
      showDiscount: int.tryParse(json['showDiscount']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (sum != null) 'sum': sum,
      if (discounts != null) 'discounts': discounts,
      if (showDiscount != null) 'showDiscount': showDiscount,
    };
  }

  @override
  List<Object?> get props => [type, name, sum, discounts, showDiscount];
}
