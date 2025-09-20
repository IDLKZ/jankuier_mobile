import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/errors/exception.dart';
import 'package:jankuier_mobile/features/kff/data/datasource/kff_datasource.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_coach_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_player_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_post_match_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@Injectable(as: KffInterface)
class KffRepository implements KffInterface {
  final KffDSInterface _dataSource;

  KffRepository(this._dataSource);

  @override
  Future<Either<Failure, List<KffLeagueEntity>>> getAllLeague() async {
    try {
      final result = await _dataSource.getAllLeague();
      return Right(result.data);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, KffLeagueEntity>> getOneLeague(int leagueId) async {
    try {
      final result = await _dataSource.getOneLeague(leagueId);
      return Right(result.data);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KffLeagueMatchEntity>>> getFutureMatches(int leagueId) async {
    try {
      final result = await _dataSource.getFutureMatches(leagueId);
      return Right(result.data);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KffLeaguePostMatchEntity>>> getPastMatches(int leagueId) async {
    try {
      final result = await _dataSource.getPastMatches(leagueId);
      return Right(result.data);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KffCoachImageEntity>>> getCoaches(int leagueId) async {
    try {
      final result = await _dataSource.getCoaches(leagueId);
      return Right(result.data);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<KffLeaguePlayerEntity>>> getPlayers(int leagueId) async {
    try {
      final result = await _dataSource.getPlayers(leagueId);
      return Right(result.data);
    } on ApiException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}