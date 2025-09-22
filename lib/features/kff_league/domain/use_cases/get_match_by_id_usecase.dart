import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@injectable
class GetMatchByIdUseCase implements UseCase<KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity>, int> {
  final KffLeagueRepository repository;

  GetMatchByIdUseCase(this.repository);

  @override
  Future<Either<Failure, KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity>>> call(int params) async {
    return await repository.getMatchById(params);
  }
}