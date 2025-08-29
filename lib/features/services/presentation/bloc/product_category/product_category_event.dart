import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_product_parameter.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/paginate_product_parameter.dart';

import '../../../domain/parameters/all_product_category_parameter.dart';

@immutable
sealed class AllProductCategoryEvent extends Equatable {}

class GetAllProductCategoryEvent extends AllProductCategoryEvent {
  final AllProductCategoryParameter parameter;
  GetAllProductCategoryEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}
