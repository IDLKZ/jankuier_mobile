import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/services/data/entities/academy/get_full_academy_entity.dart';

@immutable
abstract class GetFullAcademyDetailState extends Equatable {}

class GetFullAcademyDetailInitialState extends GetFullAcademyDetailState {
  @override
  List<Object?> get props => [];
}

class GetFullAcademyDetailLoadingState extends GetFullAcademyDetailState {
  @override
  List<Object?> get props => [];
}

class GetFullAcademyDetailFailedState extends GetFullAcademyDetailState {
  final Failure failure;
  GetFullAcademyDetailFailedState(this.failure);
  @override
  List<Object?> get props => [failure];
}

class GetFullAcademyDetailLoadedState extends GetFullAcademyDetailState {
  final GetFullAcademyEntity academy;
  GetFullAcademyDetailLoadedState(this.academy);
  @override
  List<Object?> get props => [academy];
}