import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_match_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@injectable
class GetMatchesUseCase implements UseCase<KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>, KffLeagueClubMatchParameters> {
  final KffLeagueRepository repository;

  GetMatchesUseCase(this.repository);

  @override
  Future<Either<Failure, KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>>> call(KffLeagueClubMatchParameters params) async {
    return await repository.getMatches(params);
  }
}