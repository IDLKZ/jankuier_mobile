import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/get_new_one_parameter.dart';

@immutable
sealed class GetNewOneBaseEvent {}

/// Новости с Yii: https://kff.kz/api/news/{id}
class GetNewOneFromKffEvent extends GetNewOneBaseEvent {
  final GetNewOneParameter parameter;
  GetNewOneFromKffEvent(this.parameter);
}

/// Новости с Laravel: https://kffleague.kz/api/v1/news/{id}
class GetNewOneFromKffLeagueEvent extends GetNewOneBaseEvent {
  final GetNewOneParameter parameter;
  GetNewOneFromKffLeagueEvent(this.parameter);
}
