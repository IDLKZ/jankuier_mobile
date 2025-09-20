import 'package:dartz/dartz.dart' show Left, Right;
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/interface/news_interface.dart';
import '../../domain/parameters/get_new_one_parameter.dart';
import '../../domain/parameters/get_news_parameter.dart';
import '../datasources/news_datasources.dart';
import '../entities/news_response.dart';

@Injectable(as: NewsInterface)
class NewsRepository implements NewsInterface {
  final NewsDSInterface newsDSInterface;

  const NewsRepository(this.newsDSInterface);

  /// Yii: https://kff.kz/api/news
  @override
  ResultFuture<NewsListResponse> getNewsFromKff(
      GetNewsParameter parameter,
      ) async {
    try {
      final result = await newsDSInterface.getNewsFromKff(parameter);
      return Right(result);
    } on ApiException catch (e) {
      final failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      final exception = ApiException(message: e.toString(), statusCode: 500);
      final failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  /// Laravel: https://kffleague.kz/api/v1/news
  @override
  ResultFuture<NewsListResponse> getNewsFromKffLeague(
      GetNewsParameter parameter,
      ) async {
    try {
      final result = await newsDSInterface.getNewsFromKffLeague(parameter);
      return Right(result);
    } on ApiException catch (e) {
      final failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      final exception = ApiException(message: e.toString(), statusCode: 500);
      final failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<NewsOneResponse> getNewOneFromKff(GetNewOneParameter parameter) async {
    try {
      final result = await newsDSInterface.getNewOneFromKff(parameter);
      return Right(result);
    } on ApiException catch (e) {
      final failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      final exception = ApiException(message: e.toString(), statusCode: 500);
      final failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<NewsOneResponse> getNewOneFromKffLeague(GetNewOneParameter parameter) async {
    try {
      final result = await newsDSInterface.getNewOneFromKffLeague(parameter);
      return Right(result);
    } on ApiException catch (e) {
      final failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      final exception = ApiException(message: e.toString(), statusCode: 500);
      final failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }
}
