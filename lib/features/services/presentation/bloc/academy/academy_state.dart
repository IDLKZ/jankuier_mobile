import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/common/entities/pagination_entity.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/academy_entity.dart';

@immutable
abstract class AcademyState extends Equatable {}

class AcademyInitialState extends AcademyState {
  @override
  List<Object?> get props => [];
}

class PaginateAcademyLoadingState extends AcademyState {
  @override
  List<Object?> get props => [];
}

class PaginateAcademyFailedState extends AcademyState {
  final Failure failure;
  PaginateAcademyFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class PaginateAcademyLoadedState extends AcademyState {
  final Pagination<AcademyEntity> pagination;
  final List<AcademyEntity> academies;
  PaginateAcademyLoadedState(
    this.pagination,
    this.academies,
  );
  @override
  List<Object?> get props => [academies];
}