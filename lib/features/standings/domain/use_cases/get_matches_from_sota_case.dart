import 'package:jankuier_mobile/features/standings/data/entities/match_entity.dart';
import 'package:jankuier_mobile/features/standings/domain/interface/standings_interface.dart';
import 'package:jankuier_mobile/features/standings/domain/parameters/match_parameter.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';

class GetMatchesFromSotaCase
    extends UseCaseWithParams<List<MatchEntity>, MatchParameter> {
  final StandingInterface _standingInterface;
  const GetMatchesFromSotaCase(this._standingInterface);

  @override
  ResultFuture<List<MatchEntity>> call(MatchParameter params) {
    return _standingInterface.getMatchesFromSota(params);
  }
}
