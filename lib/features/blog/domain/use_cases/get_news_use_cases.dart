import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/news_response.dart';
import '../interface/news_interface.dart';
import '../parameters/get_news_parameter.dart';

/// Yii: https://kff.kz/api/news
@injectable
class GetNewsFromKffCase
    extends UseCaseWithParams<NewsListResponse, GetNewsParameter> {
  final NewsInterface _newsInterface;
  const GetNewsFromKffCase(this._newsInterface);

  @override
  ResultFuture<NewsListResponse> call(GetNewsParameter params) {
    return _newsInterface.getNewsFromKff(params);
  }
}

/// Laravel: https://kffleague.kz/api/v1/news
@injectable
class GetNewsFromKffLeagueCase
    extends UseCaseWithParams<NewsListResponse, GetNewsParameter> {
  final NewsInterface _newsInterface;
  const GetNewsFromKffLeagueCase(this._newsInterface);

  @override
  ResultFuture<NewsListResponse> call(GetNewsParameter params) {
    return _newsInterface.getNewsFromKffLeague(params);
  }
}
