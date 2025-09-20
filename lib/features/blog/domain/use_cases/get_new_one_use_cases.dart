import 'package:injectable/injectable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/news_response.dart';
import '../interface/news_interface.dart';
import '../parameters/get_new_one_parameter.dart';

/// Yii: https://kff.kz/api/news/{id}
@injectable
class GetNewOneFromKffCase
    extends UseCaseWithParams<NewsOneResponse, GetNewOneParameter> {
  final NewsInterface _newsInterface;
  const GetNewOneFromKffCase(this._newsInterface);

  @override
  ResultFuture<NewsOneResponse> call(GetNewOneParameter params) {
    return _newsInterface.getNewOneFromKff(params);
  }
}

/// Laravel: https://kffleague.kz/api/v1/news/{id}
@injectable
class GetNewOneFromKffLeagueCase
    extends UseCaseWithParams<NewsOneResponse, GetNewOneParameter> {
  final NewsInterface _newsInterface;
  const GetNewOneFromKffLeagueCase(this._newsInterface);

  @override
  ResultFuture<NewsOneResponse> call(GetNewOneParameter params) {
    return _newsInterface.getNewOneFromKffLeague(params);
  }
}
