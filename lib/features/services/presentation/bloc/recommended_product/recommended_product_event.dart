import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_product_parameter.dart';

@immutable
sealed class RecommendedProductEvent extends Equatable {}

class GetRecommendedProductEvent extends RecommendedProductEvent {
  final PaginateProductParameter parameter;
  GetRecommendedProductEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}
