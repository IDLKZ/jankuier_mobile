import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/field/field_gallery_entity.dart';

@immutable
abstract class AllFieldGalleryState extends Equatable {}

class AllFieldGalleryInitialState extends AllFieldGalleryState {
  @override
  List<Object?> get props => [];
}

class AllFieldGalleryLoadingState extends AllFieldGalleryState {
  @override
  List<Object?> get props => [];
}

class AllFieldGalleryFailedState extends AllFieldGalleryState {
  final Failure failure;
  AllFieldGalleryFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class AllFieldGalleryLoadedState extends AllFieldGalleryState {
  final List<FieldGalleryEntity> fieldGalleries;
  AllFieldGalleryLoadedState(this.fieldGalleries);
  @override
  List<Object?> get props => [fieldGalleries];
}