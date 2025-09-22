import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_tournament_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@injectable
class GetTournamentsUseCase implements UseCase<KffLeagueTournamentWithSeasonsResponseEntity, NoParams> {
  final KffLeagueRepository repository;

  GetTournamentsUseCase(this.repository);

  @override
  Future<Either<Failure, KffLeagueTournamentWithSeasonsResponseEntity>> call(NoParams params) async {
    return await repository.getTournaments();
  }
}