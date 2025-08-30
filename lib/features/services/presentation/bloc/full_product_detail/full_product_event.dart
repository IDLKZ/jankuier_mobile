import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
sealed class FullProductEvent extends Equatable {}

class GetFullProductEvent extends FullProductEvent {
  final int productId;
  GetFullProductEvent(this.productId);
  @override
  List<Object?> get props => [productId];
}
