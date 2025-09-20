import '../../../../core/utils/typedef.dart';
import '../../data/entities/news_response.dart';
import '../parameters/get_new_one_parameter.dart';
import '../parameters/get_news_parameter.dart';

/// Репозиторий/интерфейс для получения новостей
abstract class NewsInterface {
  /// Возвращает пагинированный список новостей с учётом платформы и фильтров.
  /// Оборачивается в твой ResultFuture и NewsListResponse,

  ResultFuture<NewsListResponse> getNewsFromKff(
        GetNewsParameter parameter,
      );

  ResultFuture<NewsListResponse> getNewsFromKffLeague(
        GetNewsParameter parameter,
      );

  ResultFuture<NewsOneResponse> getNewOneFromKff(
      GetNewOneParameter parameter,
      );

  ResultFuture<NewsOneResponse> getNewOneFromKffLeague(
      GetNewOneParameter parameter,
      );
}