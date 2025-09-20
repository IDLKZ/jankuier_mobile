import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@injectable
class GetAllLeagueCase extends UseCaseWithoutParams<List<KffLeagueEntity>> {
  final KffInterface _repository;

  GetAllLeagueCase(this._repository);

  @override
  ResultFuture<List<KffLeagueEntity>> call() async {
    return await _repository.getAllLeague();
  }
}