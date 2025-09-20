import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_product_parameter.dart';

@immutable
sealed class ProductEvent extends Equatable {}

class PaginateProductEvent extends ProductEvent {
  final PaginateProductParameter parameter;
  PaginateProductEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}

class FilterProductEvent extends ProductEvent {
  final PaginateProductParameter parameter;
  FilterProductEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}
