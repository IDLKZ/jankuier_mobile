import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';

import '../../../data/entities/news_response.dart';

@immutable
abstract class GetNewsStateState extends Equatable {}

class GetNewsStateInitialState extends GetNewsStateState {
  @override
  List<Object?> get props => [];
}

class GetNewsStateLoadingState extends GetNewsStateState {
  @override
  List<Object?> get props => [];
}

class GetNewsStateFailedState extends GetNewsStateState {
  final Failure failureData;
  GetNewsStateFailedState(this.failureData);

  @override
  List<Object?> get props => [failureData];
}

class GetNewsStateSuccessState extends GetNewsStateState {
  final NewsListResponse newsResponse;
  final bool hasReachedMax;
  final bool isLoadingMore;

  GetNewsStateSuccessState(
    this.newsResponse, {
    this.hasReachedMax = false,
    this.isLoadingMore = false,
  });

  GetNewsStateSuccessState copyWith({
    NewsListResponse? newsResponse,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return GetNewsStateSuccessState(
      newsResponse ?? this.newsResponse,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }

  @override
  List<Object?> get props => [newsResponse, hasReachedMax, isLoadingMore];
}
