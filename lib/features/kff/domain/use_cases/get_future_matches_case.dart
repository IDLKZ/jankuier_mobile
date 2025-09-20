import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@injectable
class GetFutureMatchesCase extends UseCaseWithParams<List<KffLeagueMatchEntity>, int> {
  final KffInterface _repository;

  GetFutureMatchesCase(this._repository);

  @override
  ResultFuture<List<KffLeagueMatchEntity>> call(int params) async {
    return await _repository.getFutureMatches(params);
  }
}