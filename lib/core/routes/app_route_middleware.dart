import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/hive_constants.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';
import 'package:jankuier_mobile/features/tournament/data/entities/tournament_entity.dart';
import '../constants/app_route_constants.dart';
import '../utils/hive_utils.dart';

class AppRouteMiddleware {
  final hiveUtils = HiveUtils();

  Future<Map<String, dynamic>?> _readJson(String key) async {
    final raw = await hiveUtils.get<Map>(key);
    if (raw == null) return null;
    return jsonDecode(jsonEncode(raw)) as Map<String, dynamic>;
  }

  Future<CountryEntity?> _readCountry() async {
    final json = await _readJson(HiveConstant.mainCountryKey);
    return json == null ? null : CountryEntity.fromJson(json);
  }

  FutureOr<String?> tournamentMiddleware(
      BuildContext context, GoRouterState state) async {
    final int? countryId =
        await hiveUtils.get<int>(HiveConstant.mainCountryIdKey);
    final country = await _readCountry();
    if (countryId == null || country == null) {
      return AppRouteConstants.CountryListPagePath;
    }
    return null;
  }

  FutureOr<String?> standingMiddleware(
      BuildContext context, GoRouterState state) async {
    final int? seasonId =
        await hiveUtils.get<int>(HiveConstant.activeSeasonIdKey);
    final int? tournamentId =
        await hiveUtils.get<int>(HiveConstant.mainTournamentIdKey);
    if (seasonId == null || tournamentId == null) {
      return AppRouteConstants.TournamentSelectionPagePath;
    }
    return null;
  }

  FutureOr<String?> mainMiddleware(
      BuildContext context, GoRouterState state) async {
    final int? countryId =
        await hiveUtils.get<int>(HiveConstant.mainCountryIdKey);
    final country = await _readCountry();
    final int? seasonId =
        await hiveUtils.get<int>(HiveConstant.activeSeasonIdKey);
    final int? tournamentId =
        await hiveUtils.get<int>(HiveConstant.mainTournamentIdKey);

    if (countryId != null &&
        seasonId != null &&
        country != null &&
        tournamentId != null) {
      return AppRouteConstants.StandingsPagePath;
    }

    if ((countryId != null || country != null) &&
        (seasonId == null || tournamentId == null)) {
      return AppRouteConstants.TournamentSelectionPagePath;
    }

    return AppRouteConstants.CountryListPagePath;
  }
}
