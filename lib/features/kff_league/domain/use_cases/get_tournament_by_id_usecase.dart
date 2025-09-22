import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_tournament_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@injectable
class GetTournamentByIdUseCase implements UseCase<KffLeagueTournamentWithSeasonsSingleResponseEntity, int> {
  final KffLeagueRepository repository;

  GetTournamentByIdUseCase(this.repository);

  @override
  Future<Either<Failure, KffLeagueTournamentWithSeasonsSingleResponseEntity>> call(int params) async {
    return await repository.getTournamentById(params);
  }
}