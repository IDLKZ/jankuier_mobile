import 'package:jankuier_mobile/features/standings/domain/interface/standings_interface.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/score_table_team_entity.dart';

class GetStandingsTableFromSotaCase
    extends UseCaseWithoutParams<List<ScoreTableTeamEntity>> {
  final StandingInterface _standingInterface;
  const GetStandingsTableFromSotaCase(this._standingInterface);

  @override
  ResultFuture<List<ScoreTableTeamEntity>> call() {
    return _standingInterface.getStandingsTableFromSota();
  }
}
