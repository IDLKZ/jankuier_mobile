import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';

import '../../../data/entities/news_response.dart';

@immutable
abstract class GetNewOneStateState extends Equatable {}

class GetNewOneStateInitialState extends GetNewOneStateState {
  @override
  List<Object?> get props => [];
}

class GetNewOneStateLoadingState extends GetNewOneStateState {
  @override
  List<Object?> get props => [];
}

class GetNewOneStateFailedState extends GetNewOneStateState {
  final Failure failureData;

  GetNewOneStateFailedState(this.failureData);

  @override
  List<Object?> get props => [failureData];
}

class GetNewOneStateSuccessState extends GetNewOneStateState {
  final NewsOneResponse newsResponse;

  GetNewOneStateSuccessState(this.newsResponse);

  @override
  List<Object?> get props => [newsResponse];
}
