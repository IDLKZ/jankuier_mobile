import 'package:equatable/equatable.dart';

abstract class CreateProductOrderFromCartEvent extends Equatable {
  const CreateProductOrderFromCartEvent();

  @override
  List<Object?> get props => [];
}

class CreateOrderFromCart extends CreateProductOrderFromCartEvent {
  final String? phone;
  final String? email;

  const CreateOrderFromCart({this.phone, this.email});

  @override
  List<Object?> get props => [phone, email];
}
