import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';

@immutable
abstract class ProductState extends Equatable {}

class ProductInitialState extends ProductState {
  @override
  List<Object?> get props => [];
}

//Загрузка пагинации продуктов
class PaginateProductLoadingState extends ProductState {
  @override
  List<Object?> get props => [];
}

//Ошибка пагинации продуктов
class PaginateProductFailedState extends ProductState {
  final Failure failure;
  PaginateProductFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

//Загруженные пагинации продуктов
class PaginateProductLoadedState extends ProductState {
  final Pagination<ProductEntity> pagination;
  final List<ProductEntity> products;
  PaginateProductLoadedState(
    this.pagination,
    this.products,
  );
  @override
  List<Object?> get props => [products];
}
