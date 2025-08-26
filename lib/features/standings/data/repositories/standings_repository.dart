import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/features/standings/data/entities/match_entity.dart';
import 'package:jankuier_mobile/features/standings/data/entities/score_table_team_entity.dart';
import 'package:jankuier_mobile/features/standings/domain/parameters/match_parameter.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/interface/standings_interface.dart';
import '../datasources/standings_datasource.dart';

class StandingRepository implements StandingInterface {
  final StandingDSInterface standingDSInterface;
  const StandingRepository(this.standingDSInterface);

  @override
  ResultFuture<List<MatchEntity>> getMatchesFromSota(
      MatchParameter parameter) async {
    try {
      final result =
          await this.standingDSInterface.getMatchesFromSota(parameter);
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }

  @override
  ResultFuture<List<ScoreTableTeamEntity>> getStandingsTableFromSota() async {
    try {
      final result = await this.standingDSInterface.getStandingsTableFromSota();
      return Right(result);
    } on ApiException catch (e) {
      ApiFailure failure = ApiFailure.fromException(e);
      return Left(failure);
    } on Exception catch (e) {
      var exception = ApiException(message: e.toString(), statusCode: 500);
      ApiFailure failure = ApiFailure.fromException(exception);
      return Left(failure);
    }
  }
}
