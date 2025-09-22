import 'package:dartz/dartz.dart';
import 'package:jankuier_mobile/core/errors/failures.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_championship_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_season_entity.dart';
import 'package:jankuier_mobile/features/kff_league/data/entities/kff_league_tournament_entity.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_common_parameter.dart';
import 'package:jankuier_mobile/features/kff_league/domain/parameters/kff_league_match_parameter.dart';

import '../../data/entities/kff_league_pagination_response_entity.dart';

abstract class KffLeagueRepository {
  // Get Seasons
  Future<
      Either<Failure,
          KffLeaguePaginatedResponseEntity<KffLeagueSeasonEntity>>> getSeasons(
      KffLeagueCommonParameter parameter);
  Future<Either<Failure, KffLeagueSingleResponseEntity<KffLeagueSeasonEntity>>>
      getSeasonById(int seasonId);

  // Get Championships
  Future<
          Either<Failure,
              KffLeaguePaginatedResponseEntity<KffLeagueChampionshipEntity>>>
      getChampionships(KffLeagueCommonParameter parameter);
  Future<
          Either<Failure,
              KffLeagueSingleResponseEntity<KffLeagueChampionshipEntity>>>
      getChampionshipById(int championshipId);

  // Get Tournaments
  Future<Either<Failure, KffLeagueTournamentWithSeasonsResponseEntity>>
      getTournaments();
  Future<Either<Failure, KffLeagueTournamentWithSeasonsSingleResponseEntity>>
      getTournamentById(int tournamentId);

  // Get Matches
  Future<
          Either<Failure,
              KffLeaguePaginatedResponseEntity<KffLeagueClubMatchEntity>>>
      getMatches(KffLeagueClubMatchParameters parameter);
  Future<
          Either<Failure,
              KffLeagueSingleResponseEntity<KffLeagueClubMatchEntity>>>
      getMatchById(int matchId);
}
