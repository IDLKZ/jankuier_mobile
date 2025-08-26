import 'package:injectable/injectable.dart';

import '../../features/countries/data/entities/country_entity.dart';
import '../../features/tournament/data/entities/tournament_entity.dart';
import '../constants/hive_constants.dart';
import '../utils/hive_utils.dart';

@injectable
class MainSelectionService {
  final HiveUtils _hiveUtils;

  MainSelectionService(this._hiveUtils);

  // Country methods
  Future<void> saveMainCountry(CountryEntity country) async {
    await _hiveUtils.put(HiveConstant.mainCountryKey, country.toJson());
    await _hiveUtils.put(HiveConstant.mainCountryIdKey, country.id);
  }

  Future<CountryEntity?> getMainCountry() async {
    final countryJson = await _hiveUtils.get<Map<String, dynamic>>(
      HiveConstant.mainCountryKey,
    );
    if (countryJson != null) {
      return CountryEntity.fromJson(countryJson);
    }
    return null;
  }

  Future<int?> getMainCountryId() async {
    return await _hiveUtils.get<int>(HiveConstant.mainCountryIdKey);
  }

  Future<void> clearMainCountry() async {
    await _hiveUtils.delete(HiveConstant.mainCountryKey);
    await _hiveUtils.delete(HiveConstant.mainCountryIdKey);
  }

  // Tournament methods
  Future<void> saveMainTournament(TournamentEntity tournament) async {
    await _hiveUtils.put(HiveConstant.mainTournamentKey, tournament.toJson());
    await _hiveUtils.put(HiveConstant.mainTournamentIdKey, tournament.id);
    
    // Automatically select and save the latest season
    final latestSeason = _getLatestSeason(tournament.seasons);
    if (latestSeason != null) {
      await _hiveUtils.put(HiveConstant.activeSeasonIdKey, latestSeason.id);
    }
  }

  SeasonEntity? _getLatestSeason(List<SeasonEntity> seasons) {
    if (seasons.isEmpty) return null;
    
    // Find the season with the latest end date
    SeasonEntity? latestSeason;
    DateTime? latestDate;
    
    for (final season in seasons) {
      if (latestDate == null || season.endDate.isAfter(latestDate)) {
        latestDate = season.endDate;
        latestSeason = season;
      }
    }
    
    return latestSeason;
  }

  Future<TournamentEntity?> getMainTournament() async {
    final tournamentJson = await _hiveUtils.get<Map<String, dynamic>>(
      HiveConstant.mainTournamentKey,
    );
    if (tournamentJson != null) {
      return TournamentEntity.fromJson(tournamentJson);
    }
    return null;
  }

  Future<int?> getMainTournamentId() async {
    return await _hiveUtils.get<int>(HiveConstant.mainTournamentIdKey);
  }

  Future<void> clearMainTournament() async {
    await _hiveUtils.delete(HiveConstant.mainTournamentKey);
    await _hiveUtils.delete(HiveConstant.mainTournamentIdKey);
    await _hiveUtils.delete(HiveConstant.activeSeasonIdKey);
  }

  // Season methods
  Future<int?> getActiveSeasonId() async {
    return await _hiveUtils.get<int>(HiveConstant.activeSeasonIdKey);
  }

  Future<void> setActiveSeasonId(int seasonId) async {
    await _hiveUtils.put(HiveConstant.activeSeasonIdKey, seasonId);
  }

  Future<SeasonEntity?> getActiveSeason() async {
    final tournament = await getMainTournament();
    final activeSeasonId = await getActiveSeasonId();
    
    if (tournament != null && activeSeasonId != null) {
      try {
        return tournament.seasons.firstWhere((season) => season.id == activeSeasonId);
      } catch (e) {
        // If season not found, return the latest season
        return _getLatestSeason(tournament.seasons);
      }
    }
    
    return null;
  }

  // Combined methods
  Future<bool> hasMainCountry() async {
    final countryId = await getMainCountryId();
    return countryId != null;
  }

  Future<bool> hasMainTournament() async {
    final tournamentId = await getMainTournamentId();
    return tournamentId != null;
  }

  Future<void> clearAll() async {
    await clearMainCountry();
    await clearMainTournament();
  }

  Future<bool> hasActiveSeason() async {
    final seasonId = await getActiveSeasonId();
    return seasonId != null;
  }
}