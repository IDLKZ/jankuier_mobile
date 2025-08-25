import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/interface/tournament_interface.dart';
import '../../domain/parameters/get_tournament_parameter.dart';
import '../datasources/tournament_datasource.dart';
import '../entities/tournament_entity.dart';

class TournamentRepository implements TournamentInterface {
  final TournamentDSInterface tournamentDSInterface;

  const TournamentRepository(this.tournamentDSInterface);

  @override
  ResultFuture<SotaPaginationResponse<TournamentEntity>> getTournamentsFromSota(
      GetTournamentParameter parameter) async {
    try {
      final result =
          await this.tournamentDSInterface.getCountriesFromSota(parameter);
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
