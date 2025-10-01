import 'package:equatable/equatable.dart';

abstract class GetMyProductOrderByIdEvent extends Equatable {
  const GetMyProductOrderByIdEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyProductOrderById extends GetMyProductOrderByIdEvent {
  final int productOrderId;

  const LoadMyProductOrderById(this.productOrderId);

  @override
  List<Object?> get props => [productOrderId];
}
