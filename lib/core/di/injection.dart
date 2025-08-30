import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/countries/data/datasources/country_datasource.dart';
import 'package:jankuier_mobile/features/countries/data/repositories/country_repository.dart';
import 'package:jankuier_mobile/features/countries/domain/interface/country_interface.dart';
import 'package:jankuier_mobile/features/services/data/repositories/product_repository.dart';
import 'package:jankuier_mobile/features/services/domain/interface/product_interface.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../features/countries/domain/use_cases/get_countries_from_sota_case.dart';
import '../../features/countries/presentation/bloc/get_country_bloc.dart';
import '../../features/services/data/datasources/product_datasource.dart';
import '../../features/services/domain/use_cases/product/all_product_case.dart';
import '../../features/services/domain/use_cases/product/all_product_category_case.dart';
import '../../features/services/domain/use_cases/product/get_full_product_detail_case.dart';
import '../../features/services/domain/use_cases/product/paginate_product_case.dart';
import '../../features/services/presentation/bloc/recommended_product/recommended_product_bloc.dart';
import '../../features/tournament/domain/use_cases/get_tournaments_from_sota_case.dart';
import '../../features/tournament/presentation/bloc/get_tournaments/get_tournament_bloc.dart';
import '../../features/tournament/domain/interface/tournament_interface.dart';
import '../../features/tournament/data/datasources/tournament_datasource.dart';
import '../../features/tournament/data/repositories/tournament_repository.dart';
import '../network/dio_client.dart';
import '../../features/standings/data/datasources/standings_datasource.dart';
import '../../features/standings/data/repositories/standings_repository.dart';
import '../../features/standings/domain/interface/standings_interface.dart';
import '../../features/standings/domain/use_cases/get_matches_from_sota_case.dart';
import '../../features/standings/domain/use_cases/get_standings_table_from_sota_case.dart';
import '../../features/standings/presentation/bloc/standing_bloc.dart';
import '../../features/game/data/datasources/game_datasource.dart';
import '../../features/game/data/repositories/game_repository.dart';
import '../../features/game/domain/interface/game_interface.dart';
import '../../features/game/domain/use_cases/get_match_line_up_stats_by_game_id_case.dart';
import '../../features/game/domain/use_cases/get_player_stats_by_game_id_case.dart';
import '../../features/game/domain/use_cases/get_team_stats_by_game_id_case.dart';
import '../../features/game/presentation/bloc/game_bloc.dart';
import '../network/sota_dio_client.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Initialize injectable dependencies first
  getIt.init();

  // Register Dio instances with names for convenience
  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio,
      instanceName: 'mainApi');
  getIt.registerLazySingleton<Dio>(() => getIt<SotaApiDio>().dio,
      instanceName: 'sotaApi');

  // Talker
  getIt.registerLazySingleton<Talker>(() => TalkerFlutter.init());
  //Hive
  getIt.registerLazySingleton<HiveInterface>(() => Hive);
  //Country
  getIt.registerLazySingleton(() => GetCountriesFromSotaCase(getIt()));
  getIt.registerLazySingleton<CountryInterface>(
      () => CountryRepository(getIt()));
  getIt.registerLazySingleton<CountryDSInterface>(() => CountryDSImpl());

  //Tournament
  getIt.registerLazySingleton(() => GetTournamentsFromSotaCase(getIt()));
  getIt.registerLazySingleton<TournamentInterface>(
      () => TournamentRepository(getIt()));
  getIt.registerLazySingleton<TournamentDSInterface>(() => TournamentDSImpl());

  //Standings
  getIt.registerLazySingleton(() => GetStandingsTableFromSotaCase(getIt()));
  getIt.registerLazySingleton(() => GetMatchesFromSotaCase(getIt()));
  getIt.registerLazySingleton<StandingInterface>(
      () => StandingRepository(getIt()));
  getIt.registerLazySingleton<StandingDSInterface>(() => StandingDSImpl());

  //Game
  getIt.registerLazySingleton(() => GetTeamStatsByGameIdCase(getIt()));
  getIt.registerLazySingleton(() => GetPlayerStatsByGameIdCase(getIt()));
  getIt.registerLazySingleton(() => GetMatchLineUpStatsByGameIdCase(getIt()));
  getIt.registerLazySingleton<GameInterface>(() => GameRepository(getIt()));
  getIt.registerLazySingleton<GameDSInterface>(() => GameDSImpl());

  //Product
  getIt.registerLazySingleton(() => AllProductCase(getIt()));
  getIt.registerLazySingleton(() => AllProductCategoryCase(getIt()));
  getIt.registerLazySingleton(() => GetFullProductDetailCase(getIt()));
  getIt.registerLazySingleton(() => PaginateProductCase(getIt()));
  getIt.registerLazySingleton<ProductInterface>(
      () => ProductRepository(getIt()));
  getIt.registerLazySingleton<ProductDSInterface>(() => ProductDSImpl());

  // BLoCs
  getIt.registerFactory<GetCountryBloc>(
    () => GetCountryBloc(
      getCountriesFromSotaCase: getIt<GetCountriesFromSotaCase>(),
    ),
  );
  getIt.registerFactory<GetTournamentBloc>(
    () => GetTournamentBloc(
      getTournamentsFromSotaCase: getIt<GetTournamentsFromSotaCase>(),
    ),
  );
  getIt.registerFactory<StandingBloc>(
    () => StandingBloc(
      getStandingsTableFromSotaCase: getIt<GetStandingsTableFromSotaCase>(),
      getMatchesFromSotaCase: getIt<GetMatchesFromSotaCase>(),
    ),
  );
  getIt.registerFactory<GameBloc>(
    () => GameBloc(
      getTeamStatsByGameIdCase: getIt<GetTeamStatsByGameIdCase>(),
      getPlayerStatsByGameIdCase: getIt<GetPlayerStatsByGameIdCase>(),
      getMatchLineUpStatsByGameIdCase: getIt<GetMatchLineUpStatsByGameIdCase>(),
    ),
  );

  getIt.registerFactory<ProductBloc>(
    () => ProductBloc(
      paginateProductCase: getIt<PaginateProductCase>(),
    ),
  );
  getIt.registerFactory<RecommendedProductBloc>(
    () => RecommendedProductBloc(
      paginateProductCase: getIt<PaginateProductCase>(),
    ),
  );

  getIt.registerFactory<AllProductCategoryBloc>(
    () => AllProductCategoryBloc(
      allProductCategoryCase: getIt<AllProductCategoryCase>(),
    ),
  );

  getIt.registerFactory<FullProductBloc>(
    () => FullProductBloc(
      getFullProductDetailCase: getIt<GetFullProductDetailCase>(),
    ),
  );
}
