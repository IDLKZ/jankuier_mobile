import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_post_match_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@injectable
class GetPastMatchesCase extends UseCaseWithParams<List<KffLeaguePostMatchEntity>, int> {
  final KffInterface _repository;

  GetPastMatchesCase(this._repository);

  @override
  ResultFuture<List<KffLeaguePostMatchEntity>> call(int params) async {
    return await _repository.getPastMatches(params);
  }
}