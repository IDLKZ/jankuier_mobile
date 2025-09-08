import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/typedef.dart';
import '../../domain/interface/ticketon_interface.dart';
import '../../domain/parameters/ticketon_get_shows_parameter.dart';
import '../../datasources/ticketon_datasource.dart';
import '../entities/shows/ticketon_shows_entity.dart';

@Injectable(as: TicketonInterface)
class TicketonRepositoryImpl implements TicketonInterface {
  final TicketonDSInterface _ticketonDataSource;

  const TicketonRepositoryImpl(this._ticketonDataSource);

  @override
  ResultFuture<TicketonShowsDataEntity> getShows(
      TicketonGetShowsParameter parameter) async {
    try {
      final result = await _ticketonDataSource.getShows(parameter);
      return Right(result);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    } catch (e) {
      return Left(ApiFailure(
        message: e.toString(),
        statusCode: 500,
      ));
    }
  }
}