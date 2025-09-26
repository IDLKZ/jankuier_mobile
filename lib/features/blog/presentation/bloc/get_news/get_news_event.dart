import 'package:flutter/cupertino.dart';
import '../../../domain/parameters/get_news_parameter.dart';

@immutable
sealed class GetNewsBaseEvent {}

/// Новости с Yii: https://kff.kz/api/news
class GetNewsFromKffEvent extends GetNewsBaseEvent {
  final GetNewsParameter parameter;
  GetNewsFromKffEvent(this.parameter);
}

/// Новости с Laravel: https://kffleague.kz/api/v1/news
class GetNewsFromKffLeagueEvent extends GetNewsBaseEvent {
  final GetNewsParameter parameter;
  GetNewsFromKffLeagueEvent(this.parameter);
}

/// Загрузить больше новостей (пагинация) с KFF
class LoadMoreNewsFromKffEvent extends GetNewsBaseEvent {
  final GetNewsParameter parameter;
  LoadMoreNewsFromKffEvent(this.parameter);
}

/// Загрузить больше новостей (пагинация) с KFF League
class LoadMoreNewsFromKffLeagueEvent extends GetNewsBaseEvent {
  final GetNewsParameter parameter;
  LoadMoreNewsFromKffLeagueEvent(this.parameter);
}

/// Обновить контент при смене языка
class RefreshNewsContentEvent extends GetNewsBaseEvent {
  RefreshNewsContentEvent();
}
