import 'package:jankuier_mobile/core/common/entities/sota_pagination_entity.dart';
import '../../../../core/utils/typedef.dart';
import '../../data/entities/tournament_entity.dart';
import '../parameters/get_tournament_parameter.dart';

abstract class TournamentInterface {
  ResultFuture<SotaPaginationResponse<TournamentEntity>> getTournamentsFromSota(
      GetTournamentParameter parameter);
}
