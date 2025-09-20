import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@injectable
class GetOneLeagueCase extends UseCaseWithParams<KffLeagueEntity, int> {
  final KffInterface _repository;

  GetOneLeagueCase(this._repository);

  @override
  ResultFuture<KffLeagueEntity> call(int params) async {
    return await _repository.getOneLeague(params);
  }
}