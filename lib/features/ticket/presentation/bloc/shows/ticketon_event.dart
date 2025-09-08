import 'package:equatable/equatable.dart';
import '../../../domain/parameters/ticketon_get_shows_parameter.dart';

abstract class TicketonShowsEvent extends Equatable {
  const TicketonShowsEvent();

  @override
  List<Object?> get props => [];
}

class LoadTicketonShowsEvent extends TicketonShowsEvent {
  final TicketonGetShowsParameter parameter;

  const LoadTicketonShowsEvent({required this.parameter});

  @override
  List<Object?> get props => [parameter];
}
