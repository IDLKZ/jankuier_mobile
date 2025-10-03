// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:jankuier_mobile/core/network/dio_client.dart' as _i3;
import 'package:jankuier_mobile/core/network/kff_dio_client.dart' as _i4;
import 'package:jankuier_mobile/core/network/kff_league_dio_client.dart' as _i5;
import 'package:jankuier_mobile/core/network/sota_dio_client.dart' as _i6;
import 'package:jankuier_mobile/core/services/content_refresh_service.dart'
    as _i11;
import 'package:jankuier_mobile/core/services/localization_service.dart' as _i8;
import 'package:jankuier_mobile/core/services/main_selection_service.dart'
    as _i44;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i7;
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart'
    as _i14;
import 'package:jankuier_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i55;
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i54;
import 'package:jankuier_mobile/features/auth/domain/usecases/delete_account_usecase.dart'
    as _i70;
import 'package:jankuier_mobile/features/auth/domain/usecases/delete_profile_photo_usecase.dart'
    as _i71;
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i72;
import 'package:jankuier_mobile/features/auth/domain/usecases/send_verify_code_usecase.dart'
    as _i73;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i74;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i75;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart'
    as _i76;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_photo_usecase.dart'
    as _i77;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i78;
import 'package:jankuier_mobile/features/auth/domain/usecases/verify_code_usecase.dart'
    as _i79;
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_account_bloc/delete_account_bloc.dart'
    as _i115;
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_profile_photo_bloc/delete_profile_photo_bloc.dart'
    as _i95;
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart'
    as _i123;
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_bloc.dart'
    as _i105;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i118;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart'
    as _i83;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart'
    as _i94;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i114;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_photo_bloc/update_profile_photo_bloc.dart'
    as _i93;
import 'package:jankuier_mobile/features/auth/presentation/bloc/verify_code_bloc/verify_code_bloc.dart'
    as _i116;
import 'package:jankuier_mobile/features/blog/data/datasources/news_datasources.dart'
    as _i9;
import 'package:jankuier_mobile/features/blog/data/repositories/news_repository.dart'
    as _i26;
import 'package:jankuier_mobile/features/blog/domain/interface/news_interface.dart'
    as _i25;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_new_one_use_cases.dart'
    as _i31;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_news_use_cases.dart'
    as _i30;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_news/get_news_bloc.dart'
    as _i104;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_single_new/get_new_bloc.dart'
    as _i92;
import 'package:jankuier_mobile/features/booking_field_party/data/datasources/booking_field_party_datasource.dart'
    as _i36;
import 'package:jankuier_mobile/features/booking_field_party/data/repositories/booking_field_party_repository_impl.dart'
    as _i35;
import 'package:jankuier_mobile/features/booking_field_party/domain/repositories/booking_field_party_repository.dart'
    as _i34;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/create_booking_field_party_request.dart'
    as _i56;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/delete_my_field_party_request_by_id.dart'
    as _i57;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/get_all_my_field_party_request.dart'
    as _i58;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/get_my_field_party_request_by_id.dart'
    as _i59;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/create_booking_field_party_request/create_booking_field_party_request_bloc.dart'
    as _i69;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/delete_my_field_party_request_by_id/delete_my_field_party_request_by_id_bloc.dart'
    as _i98;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/get_all_my_field_party_request/get_all_my_field_party_request_bloc.dart'
    as _i68;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/get_my_field_party_request_by_id/get_my_field_party_request_by_id_bloc.dart'
    as _i121;
import 'package:jankuier_mobile/features/cart/data/datasources/cart_datasource.dart'
    as _i17;
import 'package:jankuier_mobile/features/cart/data/repositories/cart_repository_impl.dart'
    as _i16;
import 'package:jankuier_mobile/features/cart/domain/repositories/cart_repository.dart'
    as _i15;
import 'package:jankuier_mobile/features/cart/domain/usecases/add_to_cart_usecase.dart'
    as _i21;
import 'package:jankuier_mobile/features/cart/domain/usecases/clear_cart_usecase.dart'
    as _i22;
import 'package:jankuier_mobile/features/cart/domain/usecases/get_my_cart_usecase.dart'
    as _i23;
import 'package:jankuier_mobile/features/cart/domain/usecases/update_cart_item_usecase.dart'
    as _i24;
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_bloc.dart'
    as _i37;
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_bloc.dart'
    as _i67;
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_bloc.dart'
    as _i66;
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_bloc.dart'
    as _i81;
import 'package:jankuier_mobile/features/kff/data/datasource/kff_datasource.dart'
    as _i20;
import 'package:jankuier_mobile/features/kff/data/repositories/kff_repository.dart'
    as _i33;
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart'
    as _i32;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_all_league_case.dart'
    as _i38;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_coaches_case.dart'
    as _i39;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_future_matches_case.dart'
    as _i40;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_one_league_case.dart'
    as _i41;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_past_matches_case.dart'
    as _i42;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_players_case.dart'
    as _i43;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart'
    as _i82;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_bloc.dart'
    as _i80;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart'
    as _i63;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_one_league/get_one_league_bloc.dart'
    as _i65;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_bloc.dart'
    as _i62;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_players/get_players_bloc.dart'
    as _i96;
import 'package:jankuier_mobile/features/kff_league/data/datasource/kff_league_datasource.dart'
    as _i12;
import 'package:jankuier_mobile/features/kff_league/data/repositories/kff_league_repository_impl.dart'
    as _i61;
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart'
    as _i60;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championship_by_id_usecase.dart'
    as _i107;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championships_usecase.dart'
    as _i106;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_match_by_id_usecase.dart'
    as _i109;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_matches_usecase.dart'
    as _i108;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_season_by_id_usecase.dart'
    as _i111;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_seasons_usecase.dart'
    as _i110;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournament_by_id_usecase.dart'
    as _i113;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournaments_usecase.dart'
    as _i112;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/championships/championships_bloc.dart'
    as _i117;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/matches/matches_bloc.dart'
    as _i130;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/seasons/seasons_bloc.dart'
    as _i129;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/tournaments/tournaments_bloc.dart'
    as _i131;
import 'package:jankuier_mobile/features/product_order/data/datasources/product_order_datasource.dart'
    as _i47;
import 'package:jankuier_mobile/features/product_order/data/repositories/product_order_repository_impl.dart'
    as _i46;
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart'
    as _i45;
import 'package:jankuier_mobile/features/product_order/domain/usecases/cancel_or_delete_product_order_usecase.dart'
    as _i85;
import 'package:jankuier_mobile/features/product_order/domain/usecases/cancel_order_item_usecase.dart'
    as _i84;
import 'package:jankuier_mobile/features/product_order/domain/usecases/create_product_order_from_cart_usecase.dart'
    as _i86;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_all_product_order_item_status_usecase.dart'
    as _i87;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_all_product_order_status_usecase.dart'
    as _i88;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_order_by_id_usecase.dart'
    as _i90;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_order_items_by_id_usecase.dart'
    as _i91;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_orders_usecase.dart'
    as _i89;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_bloc.dart'
    as _i122;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_order_item/cancel_order_item_bloc.dart'
    as _i126;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_bloc.dart'
    as _i99;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_item_status/get_all_product_order_item_status_bloc.dart'
    as _i124;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_status/get_all_product_order_status_bloc.dart'
    as _i119;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_bloc.dart'
    as _i125;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_items_by_id/get_my_product_order_items_by_id_bloc.dart'
    as _i127;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_orders/get_my_product_orders_bloc.dart'
    as _i128;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i29;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i49;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i48;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i100;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i101;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i102;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i103;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i120;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i19;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i28;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i13;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i10;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i27;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i18;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i50;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i64;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i51;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i52;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i53;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i97;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.DioClient>(() => _i3.DioClient());
    gh.factory<_i4.KffApiDio>(() => _i4.KffApiDio());
    gh.factory<_i5.KffLeagueApiDio>(() => _i5.KffLeagueApiDio());
    gh.factory<_i6.SotaApiDio>(() => _i6.SotaApiDio());
    gh.factory<_i7.HiveUtils>(() => _i7.HiveUtils());
    gh.singletonAsync<_i8.LocalizationService>(() {
      final i = _i8.LocalizationService();
      return i.initialize().then((_) => i);
    });
    gh.factory<_i9.NewsDSInterface>(() => _i9.NewsDSImpl());
    gh.factory<_i10.TicketonOrderDSInterface>(() => _i10.TicketonOrderDSImpl());
    gh.singletonAsync<_i11.ContentRefreshService>(() async =>
        _i11.ContentRefreshService(await getAsync<_i8.LocalizationService>())
          ..initialize());
    gh.factory<_i12.KffLeagueDSInterface>(() => _i12.KffLeagueDSImpl());
    gh.factory<_i13.TicketonDSInterface>(() => _i13.TicketonDSImpl());
    gh.factory<_i14.AuthDSInterface>(() => _i14.AuthDSImpl());
    gh.factory<_i15.CartRepository>(
        () => _i16.CartRepositoryImpl(gh<_i17.CartDSInterface>()));
    gh.factory<_i18.TicketonOrderRepository>(() =>
        _i19.TicketonOrderRepositoryImpl(gh<_i10.TicketonOrderDSInterface>()));
    gh.factory<_i20.KffDSInterface>(() => _i20.KffDSImpl());
    gh.factory<_i21.AddToCartUseCase>(
        () => _i21.AddToCartUseCase(gh<_i15.CartRepository>()));
    gh.factory<_i22.ClearCartUseCase>(
        () => _i22.ClearCartUseCase(gh<_i15.CartRepository>()));
    gh.factory<_i23.GetMyCartUseCase>(
        () => _i23.GetMyCartUseCase(gh<_i15.CartRepository>()));
    gh.factory<_i24.UpdateCartItemUseCase>(
        () => _i24.UpdateCartItemUseCase(gh<_i15.CartRepository>()));
    gh.factory<_i25.NewsInterface>(
        () => _i26.NewsRepository(gh<_i9.NewsDSInterface>()));
    gh.factory<_i27.TicketonInterface>(
        () => _i28.TicketonRepositoryImpl(gh<_i13.TicketonDSInterface>()));
    gh.factory<_i29.TaskRemoteDataSource>(
        () => _i29.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i30.GetNewsFromKffCase>(
        () => _i30.GetNewsFromKffCase(gh<_i25.NewsInterface>()));
    gh.factory<_i30.GetNewsFromKffLeagueCase>(
        () => _i30.GetNewsFromKffLeagueCase(gh<_i25.NewsInterface>()));
    gh.factory<_i31.GetNewOneFromKffCase>(
        () => _i31.GetNewOneFromKffCase(gh<_i25.NewsInterface>()));
    gh.factory<_i31.GetNewOneFromKffLeagueCase>(
        () => _i31.GetNewOneFromKffLeagueCase(gh<_i25.NewsInterface>()));
    gh.factory<_i32.KffInterface>(
        () => _i33.KffRepository(gh<_i20.KffDSInterface>()));
    gh.factory<_i34.BookingFieldPartyRepository>(() =>
        _i35.BookingFieldPartyRepositoryImpl(
            gh<_i36.BookingFieldPartyDSInterface>()));
    gh.factory<_i37.AddToCartBloc>(
        () => _i37.AddToCartBloc(gh<_i21.AddToCartUseCase>()));
    gh.factory<_i38.GetAllLeagueCase>(
        () => _i38.GetAllLeagueCase(gh<_i32.KffInterface>()));
    gh.factory<_i39.GetCoachesCase>(
        () => _i39.GetCoachesCase(gh<_i32.KffInterface>()));
    gh.factory<_i40.GetFutureMatchesCase>(
        () => _i40.GetFutureMatchesCase(gh<_i32.KffInterface>()));
    gh.factory<_i41.GetOneLeagueCase>(
        () => _i41.GetOneLeagueCase(gh<_i32.KffInterface>()));
    gh.factory<_i42.GetPastMatchesCase>(
        () => _i42.GetPastMatchesCase(gh<_i32.KffInterface>()));
    gh.factory<_i43.GetPlayersCase>(
        () => _i43.GetPlayersCase(gh<_i32.KffInterface>()));
    gh.factory<_i44.MainSelectionService>(
        () => _i44.MainSelectionService(gh<_i7.HiveUtils>()));
    gh.factory<_i45.ProductOrderRepository>(() =>
        _i46.ProductOrderRepositoryImpl(gh<_i47.ProductOrderDSInterface>()));
    gh.factory<_i48.TaskRepository>(
        () => _i49.TaskRepositoryImpl(gh<_i29.TaskRemoteDataSource>()));
    gh.factory<_i50.GetTicketOrderUseCase>(
        () => _i50.GetTicketOrderUseCase(gh<_i18.TicketonOrderRepository>()));
    gh.factory<_i51.PaginateTicketOrderUseCase>(() =>
        _i51.PaginateTicketOrderUseCase(gh<_i18.TicketonOrderRepository>()));
    gh.factory<_i52.TicketonOrderCheckUseCase>(() =>
        _i52.TicketonOrderCheckUseCase(gh<_i18.TicketonOrderRepository>()));
    gh.factory<_i53.TicketonTicketCheckUseCase>(() =>
        _i53.TicketonTicketCheckUseCase(gh<_i18.TicketonOrderRepository>()));
    gh.factory<_i54.AuthRepository>(
        () => _i55.AuthRepositoryImpl(gh<_i14.AuthDSInterface>()));
    gh.factory<_i56.CreateBookingFieldPartyRequest>(() =>
        _i56.CreateBookingFieldPartyRequest(
            gh<_i34.BookingFieldPartyRepository>()));
    gh.factory<_i57.DeleteMyFieldPartyRequestById>(() =>
        _i57.DeleteMyFieldPartyRequestById(
            gh<_i34.BookingFieldPartyRepository>()));
    gh.factory<_i58.GetAllMyFieldPartyRequest>(() =>
        _i58.GetAllMyFieldPartyRequest(gh<_i34.BookingFieldPartyRepository>()));
    gh.factory<_i59.GetMyFieldPartyRequestById>(() =>
        _i59.GetMyFieldPartyRequestById(
            gh<_i34.BookingFieldPartyRepository>()));
    gh.factory<_i60.KffLeagueRepository>(
        () => _i61.KffLeagueRepositoryImpl(gh<_i12.KffLeagueDSInterface>()));
    gh.factory<_i62.GetPastMatchesBloc>(() => _i62.GetPastMatchesBloc(
        getPastMatchesCase: gh<_i42.GetPastMatchesCase>()));
    gh.factory<_i63.GetFutureMatchesBloc>(() => _i63.GetFutureMatchesBloc(
        getFutureMatchesCase: gh<_i40.GetFutureMatchesCase>()));
    gh.factory<_i64.GetTicketonShowsUseCase>(
        () => _i64.GetTicketonShowsUseCase(gh<_i27.TicketonInterface>()));
    gh.factory<_i65.GetOneLeagueBloc>(() =>
        _i65.GetOneLeagueBloc(getOneLeagueCase: gh<_i41.GetOneLeagueCase>()));
    gh.factory<_i66.MyCartBloc>(
        () => _i66.MyCartBloc(gh<_i23.GetMyCartUseCase>()));
    gh.factory<_i67.ClearCartBloc>(
        () => _i67.ClearCartBloc(gh<_i22.ClearCartUseCase>()));
    gh.factory<_i68.GetAllMyFieldPartyRequestBloc>(() =>
        _i68.GetAllMyFieldPartyRequestBloc(
            getAllMyFieldPartyRequest: gh<_i58.GetAllMyFieldPartyRequest>()));
    gh.factory<_i69.CreateBookingFieldPartyRequestBloc>(() =>
        _i69.CreateBookingFieldPartyRequestBloc(
            createBookingFieldPartyRequest:
                gh<_i56.CreateBookingFieldPartyRequest>()));
    gh.factory<_i70.DeleteAccountUseCase>(
        () => _i70.DeleteAccountUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i71.DeleteProfilePhotoUseCase>(
        () => _i71.DeleteProfilePhotoUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i72.GetMeUseCase>(
        () => _i72.GetMeUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i73.SendVerifyCodeUseCase>(
        () => _i73.SendVerifyCodeUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i74.SignInUseCase>(
        () => _i74.SignInUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i75.SignUpUseCase>(
        () => _i75.SignUpUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i76.UpdatePasswordUseCase>(
        () => _i76.UpdatePasswordUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i77.UpdateProfilePhotoUseCase>(
        () => _i77.UpdateProfilePhotoUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i78.UpdateProfileUseCase>(
        () => _i78.UpdateProfileUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i79.VerifyCodeUseCase>(
        () => _i79.VerifyCodeUseCase(gh<_i54.AuthRepository>()));
    gh.factory<_i80.GetCoachesBloc>(
        () => _i80.GetCoachesBloc(getCoachesCase: gh<_i39.GetCoachesCase>()));
    gh.factory<_i81.UpdateCartItemBloc>(
        () => _i81.UpdateCartItemBloc(gh<_i24.UpdateCartItemUseCase>()));
    gh.factory<_i82.GetAllLeagueBloc>(() =>
        _i82.GetAllLeagueBloc(getAllLeagueCase: gh<_i38.GetAllLeagueCase>()));
    gh.factory<_i83.SignUpBloc>(
        () => _i83.SignUpBloc(gh<_i75.SignUpUseCase>()));
    gh.factory<_i84.CancelOrderItemUseCase>(
        () => _i84.CancelOrderItemUseCase(gh<_i45.ProductOrderRepository>()));
    gh.factory<_i85.CancelOrDeleteProductOrderUseCase>(() =>
        _i85.CancelOrDeleteProductOrderUseCase(
            gh<_i45.ProductOrderRepository>()));
    gh.factory<_i86.CreateProductOrderFromCartUseCase>(() =>
        _i86.CreateProductOrderFromCartUseCase(
            gh<_i45.ProductOrderRepository>()));
    gh.factory<_i87.GetAllProductOrderItemStatusUseCase>(() =>
        _i87.GetAllProductOrderItemStatusUseCase(
            gh<_i45.ProductOrderRepository>()));
    gh.factory<_i88.GetAllProductOrderStatusUseCase>(() =>
        _i88.GetAllProductOrderStatusUseCase(
            gh<_i45.ProductOrderRepository>()));
    gh.factory<_i89.GetMyProductOrdersUseCase>(() =>
        _i89.GetMyProductOrdersUseCase(gh<_i45.ProductOrderRepository>()));
    gh.factory<_i90.GetMyProductOrderByIdUseCase>(() =>
        _i90.GetMyProductOrderByIdUseCase(gh<_i45.ProductOrderRepository>()));
    gh.factory<_i91.GetMyProductOrderItemsByIdUseCase>(() =>
        _i91.GetMyProductOrderItemsByIdUseCase(
            gh<_i45.ProductOrderRepository>()));
    gh.factory<_i92.GetNewOneBloc>(() => _i92.GetNewOneBloc(
          GetNewOneFromKffCase: gh<_i31.GetNewOneFromKffCase>(),
          GetNewOneFromKffLeagueCase: gh<_i31.GetNewOneFromKffLeagueCase>(),
        ));
    gh.factory<_i93.UpdateProfilePhotoBloc>(() =>
        _i93.UpdateProfilePhotoBloc(gh<_i77.UpdateProfilePhotoUseCase>()));
    gh.factory<_i94.UpdatePasswordBloc>(
        () => _i94.UpdatePasswordBloc(gh<_i76.UpdatePasswordUseCase>()));
    gh.factory<_i95.DeleteProfilePhotoBloc>(() =>
        _i95.DeleteProfilePhotoBloc(gh<_i71.DeleteProfilePhotoUseCase>()));
    gh.factory<_i96.GetPlayersBloc>(
        () => _i96.GetPlayersBloc(getPlayersCase: gh<_i43.GetPlayersCase>()));
    gh.factory<_i97.TicketonShowsBloc>(() => _i97.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i64.GetTicketonShowsUseCase>()));
    gh.factory<_i98.DeleteMyFieldPartyRequestByIdBloc>(() =>
        _i98.DeleteMyFieldPartyRequestByIdBloc(
            deleteMyFieldPartyRequestById:
                gh<_i57.DeleteMyFieldPartyRequestById>()));
    gh.factory<_i99.CreateProductOrderFromCartBloc>(() =>
        _i99.CreateProductOrderFromCartBloc(
            gh<_i86.CreateProductOrderFromCartUseCase>()));
    gh.factory<_i100.CreateTask>(
        () => _i100.CreateTask(gh<_i48.TaskRepository>()));
    gh.factory<_i101.DeleteTask>(
        () => _i101.DeleteTask(gh<_i48.TaskRepository>()));
    gh.factory<_i102.GetTasks>(() => _i102.GetTasks(gh<_i48.TaskRepository>()));
    gh.factory<_i103.UpdateTask>(
        () => _i103.UpdateTask(gh<_i48.TaskRepository>()));
    gh.factory<_i104.GetNewsBloc>(() => _i104.GetNewsBloc(
          getNewsFromKffCase: gh<_i30.GetNewsFromKffCase>(),
          getNewsFromKffLeagueCase: gh<_i30.GetNewsFromKffLeagueCase>(),
        ));
    gh.factory<_i105.SendVerifyCodeBloc>(
        () => _i105.SendVerifyCodeBloc(gh<_i73.SendVerifyCodeUseCase>()));
    gh.factory<_i106.GetChampionshipsUseCase>(
        () => _i106.GetChampionshipsUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i107.GetChampionshipByIdUseCase>(
        () => _i107.GetChampionshipByIdUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i108.GetMatchesUseCase>(
        () => _i108.GetMatchesUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i109.GetMatchByIdUseCase>(
        () => _i109.GetMatchByIdUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i110.GetSeasonsUseCase>(
        () => _i110.GetSeasonsUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i111.GetSeasonByIdUseCase>(
        () => _i111.GetSeasonByIdUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i112.GetTournamentsUseCase>(
        () => _i112.GetTournamentsUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i113.GetTournamentByIdUseCase>(
        () => _i113.GetTournamentByIdUseCase(gh<_i60.KffLeagueRepository>()));
    gh.factory<_i114.UpdateProfileBloc>(
        () => _i114.UpdateProfileBloc(gh<_i78.UpdateProfileUseCase>()));
    gh.factory<_i115.DeleteAccountBloc>(
        () => _i115.DeleteAccountBloc(gh<_i70.DeleteAccountUseCase>()));
    gh.factory<_i116.VerifyCodeBloc>(
        () => _i116.VerifyCodeBloc(gh<_i79.VerifyCodeUseCase>()));
    gh.factory<_i117.ChampionshipsBloc>(() => _i117.ChampionshipsBloc(
          gh<_i106.GetChampionshipsUseCase>(),
          gh<_i107.GetChampionshipByIdUseCase>(),
        ));
    gh.factory<_i118.SignInBloc>(() => _i118.SignInBloc(
          gh<_i74.SignInUseCase>(),
          gh<_i7.HiveUtils>(),
        ));
    gh.factory<_i119.GetAllProductOrderStatusBloc>(() =>
        _i119.GetAllProductOrderStatusBloc(
            gh<_i88.GetAllProductOrderStatusUseCase>()));
    gh.factory<_i120.TaskBloc>(() => _i120.TaskBloc(
          getTasks: gh<_i102.GetTasks>(),
          createTask: gh<_i100.CreateTask>(),
          updateTask: gh<_i103.UpdateTask>(),
          deleteTask: gh<_i101.DeleteTask>(),
        ));
    gh.factory<_i121.GetMyFieldPartyRequestByIdBloc>(() =>
        _i121.GetMyFieldPartyRequestByIdBloc(
            getMyFieldPartyRequestById: gh<_i59.GetMyFieldPartyRequestById>()));
    gh.factory<_i122.CancelOrDeleteProductOrderBloc>(() =>
        _i122.CancelOrDeleteProductOrderBloc(
            gh<_i85.CancelOrDeleteProductOrderUseCase>()));
    gh.factory<_i123.GetMeBloc>(() => _i123.GetMeBloc(
          gh<_i72.GetMeUseCase>(),
          gh<_i7.HiveUtils>(),
        ));
    gh.factory<_i124.GetAllProductOrderItemStatusBloc>(() =>
        _i124.GetAllProductOrderItemStatusBloc(
            gh<_i87.GetAllProductOrderItemStatusUseCase>()));
    gh.factory<_i125.GetMyProductOrderByIdBloc>(() =>
        _i125.GetMyProductOrderByIdBloc(
            gh<_i90.GetMyProductOrderByIdUseCase>()));
    gh.factory<_i126.CancelOrderItemBloc>(
        () => _i126.CancelOrderItemBloc(gh<_i84.CancelOrderItemUseCase>()));
    gh.factory<_i127.GetMyProductOrderItemsByIdBloc>(() =>
        _i127.GetMyProductOrderItemsByIdBloc(
            gh<_i91.GetMyProductOrderItemsByIdUseCase>()));
    gh.factory<_i128.GetMyProductOrdersBloc>(() =>
        _i128.GetMyProductOrdersBloc(gh<_i89.GetMyProductOrdersUseCase>()));
    gh.factory<_i129.SeasonsBloc>(() => _i129.SeasonsBloc(
          gh<_i110.GetSeasonsUseCase>(),
          gh<_i111.GetSeasonByIdUseCase>(),
        ));
    gh.factory<_i130.MatchesBloc>(() => _i130.MatchesBloc(
          gh<_i108.GetMatchesUseCase>(),
          gh<_i109.GetMatchByIdUseCase>(),
        ));
    gh.factory<_i131.TournamentsBloc>(() => _i131.TournamentsBloc(
          gh<_i112.GetTournamentsUseCase>(),
          gh<_i113.GetTournamentByIdUseCase>(),
        ));
    return this;
  }
}
