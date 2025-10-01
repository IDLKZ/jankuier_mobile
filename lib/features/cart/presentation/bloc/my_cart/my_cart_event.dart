import 'package:equatable/equatable.dart';

abstract class MyCartEvent extends Equatable {
  const MyCartEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyCart extends MyCartEvent {
  final bool checkCartItems;

  const LoadMyCart({this.checkCartItems = false});

  @override
  List<Object?> get props => [checkCartItems];
}
