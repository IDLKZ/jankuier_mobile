import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/entities/product/product_category_entity.dart';

@immutable
abstract class AllProductCategoryState extends Equatable {}

class AllProductCategoryInitialState extends AllProductCategoryState {
  @override
  List<Object?> get props => [];
}

//Загрузка пагинации продуктов
class AllProductCategoryLoadingState extends AllProductCategoryState {
  @override
  List<Object?> get props => [];
}

//Ошибка пагинации продуктов
class AllProductCategoryFailedState extends AllProductCategoryState {
  final Failure failure;
  AllProductCategoryFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

//Загруженные пагинации продуктов
class AllProductCategoryLoadedState extends AllProductCategoryState {
  final List<ProductCategoryEntity> productCategories;
  AllProductCategoryLoadedState(
    this.productCategories,
  );
  @override
  List<Object?> get props => [productCategories];
}
