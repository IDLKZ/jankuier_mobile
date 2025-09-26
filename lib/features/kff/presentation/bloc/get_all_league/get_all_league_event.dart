import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
abstract class GetAllLeagueEvent extends Equatable {}

class GetAllLeagueRequestEvent extends GetAllLeagueEvent {
  @override
  List<Object?> get props => [];
}

/// Обновить лиги при смене языка
class RefreshAllLeagueContentEvent extends GetAllLeagueEvent {
  @override
  List<Object?> get props => [];
}