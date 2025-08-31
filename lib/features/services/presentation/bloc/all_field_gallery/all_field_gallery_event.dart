import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/features/services/domain/parameters/all_field_gallery_parameter.dart';

@immutable
sealed class AllFieldGalleryEvent extends Equatable {}

class GetAllFieldGalleryEvent extends AllFieldGalleryEvent {
  final AllFieldGalleryFilter parameter;
  GetAllFieldGalleryEvent(this.parameter);
  @override
  List<Object?> get props => [parameter];
}