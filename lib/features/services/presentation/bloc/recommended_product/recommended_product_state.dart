import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/product/product_entity.dart';

@immutable
abstract class RecommendedProductState extends Equatable {}

class RecommendedProductInitialState extends RecommendedProductState {
  @override
  List<Object?> get props => [];
}

class RecommendedProductLoadingState extends RecommendedProductState {
  @override
  List<Object?> get props => [];
}

//Ошибка пагинации продуктов
class RecommendedProductFailedState extends RecommendedProductState {
  final Failure failure;
  RecommendedProductFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

//Загруженные пагинации продуктов
class RecommendedProductLoadedState extends RecommendedProductState {
  final Pagination<ProductEntity> pagination;
  RecommendedProductLoadedState(
    this.pagination,
  );
  @override
  List<Object?> get props => [pagination];
}
