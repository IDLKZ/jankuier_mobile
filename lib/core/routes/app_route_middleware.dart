import 'dart:async';
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:jankuier_mobile/core/constants/hive_constants.dart';
import 'package:jankuier_mobile/features/auth/data/entities/user_entity.dart';
import 'package:jankuier_mobile/features/countries/data/entities/country_entity.dart';
import 'package:jankuier_mobile/features/tournament/data/entities/tournament_entity.dart';
import '../../features/local_auth/domain/repository/local_auth_interface.dart';
import '../constants/app_route_constants.dart';
import '../errors/failures.dart';
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

  Future<String?> checkAuthMiddleware(
      BuildContext context, GoRouterState state) async {
    UserEntity? currentUser = await hiveUtils.getCurrentUser();
    String? bearerToken = await hiveUtils.getAccessToken();
    if (currentUser == null || bearerToken == null) {
      await hiveUtils.clearAllUserData();
      return AppRouteConstants.SignInPagePath;
    }
    return null;
  }

  Future<String?> checkGuestMiddleware(
      BuildContext context, GoRouterState state) async {
    UserEntity? currentUser = await hiveUtils.getCurrentUser();
    String? bearerToken = await hiveUtils.getAccessToken();
    if (currentUser != null || bearerToken != null) {
      return "/";
    }
    return null;
  }

  Future<String?> setLocalAuthBefore(BuildContext context, GoRouterState state,
      LocalAuthInterface authInterface) async {
    String? way = AppRouteConstants.MyFirstLocalAuthPagePath;
    Either<Failure, bool> result = await authInterface.getPinHashBefore();
    result.fold(
      (Failure failure) => {},
      (bool result) => {
        if (result == true) {way = null}
      },
    );
    return way;
  }

  Future<String?> refreshAuthTokenViaLocalAuth(
    BuildContext context,
    GoRouterState state,
    LocalAuthInterface authInterface,
  ) async {
    String way = AppRouteConstants.SignInPagePath;

    final Either<Failure, bool> result = await authInterface.getPinHashBefore();
    final String? refreshToken = await hiveUtils.getRefreshToken();

    if (refreshToken != null) {
      result.fold(
        (failure) {
          debugPrint("Ошибка проверки PIN: ${failure.message}");
        },
        (hasPin) {
          if (hasPin) {
            way = AppRouteConstants.RefreshTokenViaLocalAuthPagePath;
          }
        },
      );
    } else {
      await hiveUtils.clearCurrentUser();
      await hiveUtils.clearAllTokens();
    }
    return way;
  }
}
