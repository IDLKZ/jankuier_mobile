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
import '../../features/countries/domain/use_cases/get_cities_case.dart';
import '../../features/countries/presentation/bloc/get_country_bloc.dart';
import '../../features/countries/presentation/bloc/get_cities_bloc/get_cities_bloc.dart';
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
import '../../features/kff/data/datasource/kff_datasource.dart';
import '../../features/kff/data/repositories/kff_repository.dart';
import '../../features/kff/domain/interface/kff_interface.dart';
import '../../features/kff/domain/use_cases/get_all_league_case.dart';
import '../../features/kff/domain/use_cases/get_one_league_case.dart';
import '../../features/kff/domain/use_cases/get_future_matches_case.dart';
import '../../features/kff/domain/use_cases/get_past_matches_case.dart';
import '../../features/kff/domain/use_cases/get_coaches_case.dart';
import '../../features/kff/domain/use_cases/get_players_case.dart';
import '../../features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart';
import '../../features/kff/presentation/bloc/get_one_league/get_one_league_bloc.dart';
import '../../features/kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart';
import '../../features/kff/presentation/bloc/get_past_matches/get_past_matches_bloc.dart';
import '../../features/kff/presentation/bloc/get_coaches/get_coaches_bloc.dart';
import '../../features/kff/presentation/bloc/get_players/get_players_bloc.dart';
// KFF League imports
import '../../features/kff_league/data/repositories/kff_league_repository_impl.dart';
import '../../features/kff_league/domain/repositories/kff_league_repository.dart';
import '../../features/kff_league/domain/use_cases/get_seasons_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_season_by_id_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_championships_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_championship_by_id_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_tournaments_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_tournament_by_id_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_matches_usecase.dart';
import '../../features/kff_league/domain/use_cases/get_match_by_id_usecase.dart';
import '../../features/kff_league/presentation/bloc/seasons/seasons_bloc.dart';
import '../../features/kff_league/presentation/bloc/championships/championships_bloc.dart';
import '../../features/kff_league/presentation/bloc/tournaments/tournaments_bloc.dart';
import '../../features/kff_league/presentation/bloc/matches/matches_bloc.dart';
import '../network/sota_dio_client.dart';
import '../../features/cart/data/datasources/cart_datasource.dart';
import '../../features/cart/data/repositories/cart_repository_impl.dart';
import '../../features/cart/domain/repositories/cart_repository.dart';
import '../../features/cart/domain/usecases/add_to_cart_usecase.dart';
import '../../features/cart/domain/usecases/update_cart_item_usecase.dart';
import '../../features/cart/domain/usecases/clear_cart_usecase.dart';
import '../../features/cart/domain/usecases/get_my_cart_usecase.dart';
import '../../features/cart/presentation/bloc/add_to_cart/add_to_cart_bloc.dart';
import '../../features/cart/presentation/bloc/update_cart_item/update_cart_item_bloc.dart';
import '../../features/cart/presentation/bloc/clear_cart/clear_cart_bloc.dart';
import '../../features/cart/presentation/bloc/my_cart/my_cart_bloc.dart';
import '../../features/product_order/data/datasources/product_order_datasource.dart';
import '../../features/product_order/data/repositories/product_order_repository_impl.dart';
import '../../features/product_order/domain/repositories/product_order_repository.dart';
import '../../features/product_order/domain/usecases/get_my_product_orders_usecase.dart';
import '../../features/product_order/domain/usecases/get_my_product_order_by_id_usecase.dart';
import '../../features/product_order/domain/usecases/get_my_product_order_items_by_id_usecase.dart';
import '../../features/product_order/domain/usecases/create_product_order_from_cart_usecase.dart';
import '../../features/product_order/domain/usecases/cancel_or_delete_product_order_usecase.dart';
import '../../features/product_order/domain/usecases/cancel_order_item_usecase.dart';
import '../../features/product_order/domain/usecases/get_all_product_order_status_usecase.dart';
import '../../features/product_order/domain/usecases/get_all_product_order_item_status_usecase.dart';
import '../../features/product_order/presentation/bloc/get_my_product_orders/get_my_product_orders_bloc.dart';
import '../../features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_bloc.dart';
import '../../features/product_order/presentation/bloc/get_my_product_order_items_by_id/get_my_product_order_items_by_id_bloc.dart';
import '../../features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_bloc.dart';
import '../../features/product_order/presentation/bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_bloc.dart';
import '../../features/product_order/presentation/bloc/cancel_order_item/cancel_order_item_bloc.dart';
import '../../features/product_order/presentation/bloc/get_all_product_order_status/get_all_product_order_status_bloc.dart';
import '../../features/product_order/presentation/bloc/get_all_product_order_item_status/get_all_product_order_item_status_bloc.dart';
// Booking Field Party imports
import '../../features/booking_field_party/data/datasources/booking_field_party_datasource.dart';
import '../../features/booking_field_party/data/repositories/booking_field_party_repository_impl.dart';
import '../../features/booking_field_party/domain/repositories/booking_field_party_repository.dart';
import '../../features/booking_field_party/domain/usecases/create_booking_field_party_request.dart';
import '../../features/booking_field_party/domain/usecases/get_my_field_party_request_by_id.dart';
import '../../features/booking_field_party/domain/usecases/get_all_my_field_party_request.dart';
import '../../features/booking_field_party/domain/usecases/delete_my_field_party_request_by_id.dart';
import '../../features/booking_field_party/presentation/bloc/create_booking_field_party_request/create_booking_field_party_request_bloc.dart';
import '../../features/booking_field_party/presentation/bloc/get_my_field_party_request_by_id/get_my_field_party_request_by_id_bloc.dart';
import '../../features/booking_field_party/presentation/bloc/get_all_my_field_party_request/get_all_my_field_party_request_bloc.dart';
import '../../features/booking_field_party/presentation/bloc/delete_my_field_party_request_by_id/delete_my_field_party_request_by_id_bloc.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Register datasources BEFORE getIt.init() to avoid conflicts
  getIt.registerLazySingleton<CartDSInterface>(() => CartDSImpl());
  getIt.registerLazySingleton<ProductOrderDSInterface>(
      () => ProductOrderDSImpl());
  getIt.registerLazySingleton<BookingFieldPartyDSInterface>(
      () => BookingFieldPartyDSImpl());

  // Initialize injectable dependencies
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
  getIt.registerLazySingleton(() => GetCitiesCase(getIt()));
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
  getIt.registerFactory<GetCitiesBloc>(
    () => GetCitiesBloc(
      getCitiesCase: getIt<GetCitiesCase>(),
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
