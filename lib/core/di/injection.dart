import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/countries/data/datasources/country_datasource.dart';
import 'package:jankuier_mobile/features/countries/data/repositories/country_repository.dart';
import 'package:jankuier_mobile/features/countries/domain/interface/country_interface.dart';
import 'package:jankuier_mobile/features/services/data/repositories/product_repository.dart';
import 'package:jankuier_mobile/features/services/domain/interface/product_interface.dart';
import 'package:jankuier_mobile/features/services/data/repositories/field_repository.dart';
import 'package:jankuier_mobile/features/services/domain/interface/field_interface.dart';
import 'package:jankuier_mobile/features/services/data/repositories/academy_repository.dart';
import 'package:jankuier_mobile/features/services/domain/interface/academy_interface.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/full_product_detail/full_product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product/product_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/product_category/product_category_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field/field_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field/all_field_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_field_detail/get_field_detail_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party/field_party_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field_party/all_field_party_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_field_party_detail/get_field_party_detail_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/all_field_gallery/all_field_gallery_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/field_party_schedule_preview/field_party_schedule_preview_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy/academy_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/get_full_academy_detail/get_full_academy_detail_bloc.dart';
import 'package:jankuier_mobile/features/services/presentation/bloc/academy_group_schedule/academy_group_schedule_bloc.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../features/countries/domain/use_cases/get_countries_from_sota_case.dart';
import '../../features/countries/presentation/bloc/get_country_bloc.dart';
import '../../features/services/data/datasources/product_datasource.dart';
import '../../features/services/data/datasources/field_datasource.dart';
import '../../features/services/data/datasources/academy_datasource.dart';
import '../../features/services/domain/use_cases/product/all_product_case.dart';
import '../../features/services/domain/use_cases/product/all_product_category_case.dart';
import '../../features/services/domain/use_cases/product/get_full_product_detail_case.dart';
import '../../features/services/domain/use_cases/product/paginate_product_case.dart';
import '../../features/services/domain/use_cases/field/all_field_case.dart';
import '../../features/services/domain/use_cases/field/all_field_gallery_case.dart';
import '../../features/services/domain/use_cases/field/all_field_party_case.dart';
import '../../features/services/domain/use_cases/field/get_field_case.dart';
import '../../features/services/domain/use_cases/field/get_field_party_case.dart';
import '../../features/services/domain/use_cases/field/get_field_party_schedule_preview_case.dart';
import '../../features/services/domain/use_cases/field/paginate_field_case.dart';
import '../../features/services/domain/use_cases/field/paginate_field_party_case.dart';
import '../../features/services/domain/use_cases/academy/get_academy_group_schedule_case.dart';
import '../../features/services/domain/use_cases/academy/get_full_academy_detail_case.dart';
import '../../features/services/domain/use_cases/academy/paginate_academy_case.dart';
import '../../features/services/presentation/bloc/recommended_product/recommended_product_bloc.dart';
import '../../features/ticket/domain/use_cases/ticketon_order_check_usecase.dart';
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
import '../../features/ticket/datasources/ticketon_datasource.dart';
import '../../features/ticket/datasources/ticketon_order_datasource.dart';
import '../../features/ticket/data/repositories/ticketon_repository_impl.dart';
import '../../features/ticket/data/repositories/ticketon_order_repository_impl.dart';
import '../../features/ticket/domain/interface/ticketon_interface.dart';
import '../../features/ticket/domain/interface/ticketon_order_repository.dart';
import '../../features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart';
import '../../features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart';
import '../../features/ticket/presentation/bloc/shows/ticketon_bloc.dart';
import '../../features/ticket/presentation/bloc/paginate_ticket_order/paginate_ticket_order_bloc.dart';
import '../../features/ticket/presentation/bloc/ticketon_order_check/ticketon_order_check_bloc.dart';
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

  //Field
  getIt.registerLazySingleton(() => AllFieldCase(getIt()));
  getIt.registerLazySingleton(() => AllFieldGalleryCase(getIt()));
  getIt.registerLazySingleton(() => AllFieldPartyCase(getIt()));
  getIt.registerLazySingleton(() => GetFieldCase(getIt()));
  getIt.registerLazySingleton(() => GetFieldPartyCase(getIt()));
  getIt.registerLazySingleton(() => GetFieldPartySchedulePreviewCase(getIt()));
  getIt.registerLazySingleton(() => PaginateFieldCase(getIt()));
  getIt.registerLazySingleton(() => PaginateFieldPartyCase(getIt()));
  getIt.registerLazySingleton<FieldInterface>(() => FieldRepository(getIt()));
  getIt.registerLazySingleton<FieldDSInterface>(() => FieldDSImpl());

  //Academy
  getIt.registerLazySingleton(() => GetAcademyGroupScheduleCase(getIt()));
  getIt.registerLazySingleton(() => GetFullAcademyDetailCase(getIt()));
  getIt.registerLazySingleton(() => PaginateAcademyCase(getIt()));
  getIt.registerLazySingleton<AcademyInterface>(
      () => AcademyRepository(getIt()));
  getIt.registerLazySingleton<AcademyDSInterface>(() => AcademyDSImpl());

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

  // Field BLoCs
  getIt.registerFactory<FieldBloc>(
    () => FieldBloc(
      paginateFieldCase: getIt<PaginateFieldCase>(),
    ),
  );

  getIt.registerFactory<AllFieldBloc>(
    () => AllFieldBloc(
      allFieldCase: getIt<AllFieldCase>(),
    ),
  );

  getIt.registerFactory<GetFieldDetailBloc>(
    () => GetFieldDetailBloc(
      getFieldCase: getIt<GetFieldCase>(),
    ),
  );

  getIt.registerFactory<FieldPartyBloc>(
    () => FieldPartyBloc(
      paginateFieldPartyCase: getIt<PaginateFieldPartyCase>(),
    ),
  );

  getIt.registerFactory<AllFieldPartyBloc>(
    () => AllFieldPartyBloc(
      allFieldPartyCase: getIt<AllFieldPartyCase>(),
    ),
  );

  getIt.registerFactory<GetFieldPartyDetailBloc>(
    () => GetFieldPartyDetailBloc(
      getFieldPartyCase: getIt<GetFieldPartyCase>(),
    ),
  );

  getIt.registerFactory<AllFieldGalleryBloc>(
    () => AllFieldGalleryBloc(
      allFieldGalleryCase: getIt<AllFieldGalleryCase>(),
    ),
  );

  getIt.registerFactory<FieldPartySchedulePreviewBloc>(
    () => FieldPartySchedulePreviewBloc(
      getFieldPartySchedulePreviewCase:
          getIt<GetFieldPartySchedulePreviewCase>(),
    ),
  );

  // Academy BLoCs
  getIt.registerFactory<AcademyBloc>(
    () => AcademyBloc(
      paginateAcademyCase: getIt<PaginateAcademyCase>(),
    ),
  );

  getIt.registerFactory<GetFullAcademyDetailBloc>(
    () => GetFullAcademyDetailBloc(
      getFullAcademyDetailCase: getIt<GetFullAcademyDetailCase>(),
    ),
  );

  getIt.registerFactory<AcademyGroupScheduleBloc>(
    () => AcademyGroupScheduleBloc(
      getAcademyGroupScheduleCase: getIt<GetAcademyGroupScheduleCase>(),
    ),
  );

  // Ticket Order BLoCs
  getIt.registerFactory<PaginateTicketOrderBloc>(
    () => PaginateTicketOrderBloc(
      paginateTicketOrderUseCase: getIt<PaginateTicketOrderUseCase>(),
    ),
  );

  getIt.registerFactory<TicketonOrderCheckBloc>(
    () => TicketonOrderCheckBloc(
      ticketonOrderCheckUseCase: getIt<TicketonOrderCheckUseCase>(),
    ),
  );
}
