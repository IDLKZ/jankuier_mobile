import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import '../../../data/entities/product/full_product_entity.dart';

@immutable
abstract class GetFullProductState extends Equatable {}

class GetFullProductInitialState extends GetFullProductState {
  @override
  List<Object?> get props => [];
}

//Загрузка пагинации продуктов
class GetFullProductLoadingState extends GetFullProductState {
  @override
  List<Object?> get props => [];
}

//Ошибка пагинации продуктов
class GetFullProductFailedState extends GetFullProductState {
  final Failure failure;
  GetFullProductFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

//Загруженные пагинации продуктов
class GetFullProductLoadedState extends GetFullProductState {
  final FullProductEntity result;
  GetFullProductLoadedState(
    this.result,
  );
  @override
  List<Object?> get props => [result];
}
