import 'package:jankuier_mobile/core/utils/typedef.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_coach_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_match_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_player_entity.dart';
import 'package:jankuier_mobile/features/kff/data/entities/from_kff/kff_league_post_match_entity.dart';

abstract class KffInterface {
  ResultFuture<List<KffLeagueEntity>> getAllLeague();
  ResultFuture<KffLeagueEntity> getOneLeague(int leagueId);
  ResultFuture<List<KffLeagueMatchEntity>> getFutureMatches(int leagueId);
  ResultFuture<List<KffLeaguePostMatchEntity>> getPastMatches(int leagueId);
  ResultFuture<List<KffCoachImageEntity>> getCoaches(int leagueId);
  ResultFuture<List<KffLeaguePlayerEntity>> getPlayers(int leagueId);
}