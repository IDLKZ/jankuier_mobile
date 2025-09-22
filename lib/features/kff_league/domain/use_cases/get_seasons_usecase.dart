import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_season_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_common_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@injectable
class GetSeasonsUseCase implements UseCase<KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity>, KffLeagueCommonParameter> {
  final KffLeagueRepository repository;

  GetSeasonsUseCase(this.repository);

  @override
  Future<Either<Failure, KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity>>> call(KffLeagueCommonParameter params) async {
    return await repository.getSeasons(params);
  }
}