import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/tournament_entity.dart';
import '../interface/tournament_interface.dart';
import '../parameters/get_tournament_parameter.dart';

class GetTournamentsFromSotaCase extends UseCaseWithParams<
    SotaPaginationResponse<TournamentEntity>, GetTournamentParameter> {
  final TournamentInterface _tournamentInterface;
  const GetTournamentsFromSotaCase(this._tournamentInterface);

  @override
  ResultFuture<SotaPaginationResponse<TournamentEntity>> call(
      GetTournamentParameter params) {
    return _tournamentInterface.getTournamentsFromSota(params);
  }
}
