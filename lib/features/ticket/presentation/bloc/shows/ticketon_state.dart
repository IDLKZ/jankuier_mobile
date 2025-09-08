import 'package:equatable/equatable.dart';

import '../../../data/entities/shows/ticketon_shows_entity.dart';

abstract class TicketonShowsState extends Equatable {
  const TicketonShowsState();

  @override
  List<Object?> get props => [];
}

class TicketonShowsInitial extends TicketonShowsState {
  const TicketonShowsInitial();
}

class TicketonShowsLoading extends TicketonShowsState {
  const TicketonShowsLoading();
}

class TicketonShowsShowsLoaded extends TicketonShowsState {
  final TicketonShowsDataEntity shows;

  const TicketonShowsShowsLoaded({required this.shows});

  @override
  List<Object?> get props => [shows];
}

class TicketonShowsError extends TicketonShowsState {
  final String message;

  const TicketonShowsError({required this.message});

  @override
  List<Object?> get props => [message];
}
