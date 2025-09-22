import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_championship_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_pagination_response_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart';

@injectable
class GetChampionshipByIdUseCase implements UseCase<KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity>, int> {
  final KffLeagueRepository repository;

  GetChampionshipByIdUseCase(this.repository);

  @override
  Future<Either<Failure, KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity>>> call(int params) async {
    return await repository.getChampionshipById(params);
  }
}