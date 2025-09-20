import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/core/usecases/usecase.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_player_entity.dart';
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart';

@injectable
class GetPlayersCase extends UseCaseWithParams<List<KffLeaguePlayerEntity>, int> {
  final KffInterface _repository;

  GetPlayersCase(this._repository);

  @override
  ResultFuture<List<KffLeaguePlayerEntity>> call(int params) async {
    return await _repository.getPlayers(params);
  }
}