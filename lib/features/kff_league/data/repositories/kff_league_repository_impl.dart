import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff_league/data/datasource/kff_league_datasource.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_championship_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_season_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_tournament_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_common_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_match_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@Injectable(as: KffLeagueRepository)
class KffLeagueRepositoryImpl implements KffLeagueRepository {
  final KffLeagueDSInterface _dataSource;

  KffLeagueRepositoryImpl(this._dataSource);

  @override
  Future<Either<Failure, KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity>>> getSeasons(
      KffLeagueCommonParameter parameter) async {
    try {
      final result = await _dataSource.getSeasons(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeagueSingleResponseEntity<KffLeagueSeasonEntity>>> getSeasonById(
      int seasonId) async {
    try {
      final result = await _dataSource.getSeasonById(seasonId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeaguePaginatedResponseEntity<KffLeagueChampionshipEntity>>> getChampionships(
      KffLeagueCommonParameter parameter) async {
    try {
      final result = await _dataSource.getChampionships(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity>>> getChampionshipById(
      int championshipId) async {
    try {
      final result = await _dataSource.getChampionshipById(championshipId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeagueTournamentWithSeasonsResponseEntity>> getTournaments() async {
    try {
      final result = await _dataSource.getTournaments();
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeagueTournamentWithSeasonsSingleResponseEntity>> getTournamentById(
      int tournamentId) async {
    try {
      final result = await _dataSource.getTournamentById(tournamentId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>>> getMatches(
      KffLeagueClubMatchParameters parameter) async {
    try {
      final result = await _dataSource.getMatches(parameter);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity>>> getMatchById(
      int matchId) async {
    try {
      final result = await _dataSource.getMatchById(matchId);
      return Right(result);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}