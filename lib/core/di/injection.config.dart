// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:jankuier_mobile/core/network/dio_client.dart' as _i59;
import 'package:jankuier_mobile/core/network/kff_dio_client.dart' as _i947;
import 'package:jankuier_mobile/core/network/kff_league_dio_client.dart'
    as _i633;
import 'package:jankuier_mobile/core/network/sota_dio_client.dart' as _i176;
import 'package:jankuier_mobile/core/services/content_refresh_service.dart'
    as _i633;
import 'package:jankuier_mobile/core/services/localization_service.dart'
    as _i530;
import 'package:jankuier_mobile/core/services/main_selection_service.dart'
    as _i570;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i854;
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart'
    as _i644;
import 'package:jankuier_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i580;
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i106;
import 'package:jankuier_mobile/features/auth/domain/usecases/delete_account_usecase.dart'
    as _i536;
import 'package:jankuier_mobile/features/auth/domain/usecases/delete_profile_photo_usecase.dart'
    as _i189;
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i477;
import 'package:jankuier_mobile/features/auth/domain/usecases/refresh_token_usecase.dart'
    as _i391;
import 'package:jankuier_mobile/features/auth/domain/usecases/send_verify_code_usecase.dart'
    as _i398;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i2;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i153;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart'
    as _i194;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_photo_usecase.dart'
    as _i1047;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i625;
import 'package:jankuier_mobile/features/auth/domain/usecases/verify_code_usecase.dart'
    as _i517;
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_account_bloc/delete_account_bloc.dart'
    as _i347;
import 'package:jankuier_mobile/features/auth/presentation/bloc/delete_profile_photo_bloc/delete_profile_photo_bloc.dart'
    as _i732;
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart'
    as _i278;
import 'package:jankuier_mobile/features/auth/presentation/bloc/refresh_token_bloc/refresh_token_bloc.dart'
    as _i604;
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_bloc.dart'
    as _i59;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i255;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart'
    as _i111;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart'
    as _i176;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i663;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_photo_bloc/update_profile_photo_bloc.dart'
    as _i934;
import 'package:jankuier_mobile/features/auth/presentation/bloc/verify_code_bloc/verify_code_bloc.dart'
    as _i865;
import 'package:jankuier_mobile/features/blog/data/datasources/news_datasources.dart'
    as _i100;
import 'package:jankuier_mobile/features/blog/data/repositories/news_repository.dart'
    as _i80;
import 'package:jankuier_mobile/features/blog/domain/interface/news_interface.dart'
    as _i858;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_new_one_use_cases.dart'
    as _i92;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_news_use_cases.dart'
    as _i904;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_news/get_news_bloc.dart'
    as _i349;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_single_new/get_new_bloc.dart'
    as _i555;
import 'package:jankuier_mobile/features/booking_field_party/data/datasources/booking_field_party_datasource.dart'
    as _i335;
import 'package:jankuier_mobile/features/booking_field_party/data/repositories/booking_field_party_repository_impl.dart'
    as _i350;
import 'package:jankuier_mobile/features/booking_field_party/domain/repositories/booking_field_party_repository.dart'
    as _i821;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/create_booking_field_party_request.dart'
    as _i514;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/delete_my_field_party_request_by_id.dart'
    as _i1056;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/get_all_my_field_party_request.dart'
    as _i115;
import 'package:jankuier_mobile/features/booking_field_party/domain/usecases/get_my_field_party_request_by_id.dart'
    as _i238;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/create_booking_field_party_request/create_booking_field_party_request_bloc.dart'
    as _i190;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/delete_my_field_party_request_by_id/delete_my_field_party_request_by_id_bloc.dart'
    as _i17;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/get_all_my_field_party_request/get_all_my_field_party_request_bloc.dart'
    as _i843;
import 'package:jankuier_mobile/features/booking_field_party/presentation/bloc/get_my_field_party_request_by_id/get_my_field_party_request_by_id_bloc.dart'
    as _i52;
import 'package:jankuier_mobile/features/cart/data/datasources/cart_datasource.dart'
    as _i948;
import 'package:jankuier_mobile/features/cart/data/repositories/cart_repository_impl.dart'
    as _i648;
import 'package:jankuier_mobile/features/cart/domain/repositories/cart_repository.dart'
    as _i888;
import 'package:jankuier_mobile/features/cart/domain/usecases/add_to_cart_usecase.dart'
    as _i16;
import 'package:jankuier_mobile/features/cart/domain/usecases/clear_cart_usecase.dart'
    as _i515;
import 'package:jankuier_mobile/features/cart/domain/usecases/get_my_cart_usecase.dart'
    as _i521;
import 'package:jankuier_mobile/features/cart/domain/usecases/update_cart_item_usecase.dart'
    as _i876;
import 'package:jankuier_mobile/features/cart/presentation/bloc/add_to_cart/add_to_cart_bloc.dart'
    as _i915;
import 'package:jankuier_mobile/features/cart/presentation/bloc/clear_cart/clear_cart_bloc.dart'
    as _i771;
import 'package:jankuier_mobile/features/cart/presentation/bloc/my_cart/my_cart_bloc.dart'
    as _i745;
import 'package:jankuier_mobile/features/cart/presentation/bloc/update_cart_item/update_cart_item_bloc.dart'
    as _i493;
import 'package:jankuier_mobile/features/kff/data/datasource/kff_datasource.dart'
    as _i105;
import 'package:jankuier_mobile/features/kff/data/repositories/kff_repository.dart'
    as _i390;
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart'
    as _i209;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_all_league_case.dart'
    as _i104;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_coaches_case.dart'
    as _i272;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_future_matches_case.dart'
    as _i681;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_one_league_case.dart'
    as _i81;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_past_matches_case.dart'
    as _i768;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_players_case.dart'
    as _i631;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart'
    as _i779;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_bloc.dart'
    as _i449;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart'
    as _i843;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_one_league/get_one_league_bloc.dart'
    as _i610;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_bloc.dart'
    as _i545;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_players/get_players_bloc.dart'
    as _i1050;
import 'package:jankuier_mobile/features/kff_league/data/datasource/kff_league_datasource.dart'
    as _i320;
import 'package:jankuier_mobile/features/kff_league/data/repositories/kff_league_repository_impl.dart'
    as _i422;
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart'
    as _i439;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championship_by_id_usecase.dart'
    as _i936;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championships_usecase.dart'
    as _i738;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_match_by_id_usecase.dart'
    as _i78;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_matches_usecase.dart'
    as _i52;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_season_by_id_usecase.dart'
    as _i1029;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_seasons_usecase.dart'
    as _i135;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournament_by_id_usecase.dart'
    as _i970;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournaments_usecase.dart'
    as _i446;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/championships/championships_bloc.dart'
    as _i897;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/matches/matches_bloc.dart'
    as _i492;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/seasons/seasons_bloc.dart'
    as _i1006;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/tournaments/tournaments_bloc.dart'
    as _i313;
import 'package:jankuier_mobile/features/notifications/data/datasources/notification_datasource.dart'
    as _i972;
import 'package:jankuier_mobile/features/notifications/data/repositories/notification_repository_impl.dart'
    as _i720;
import 'package:jankuier_mobile/features/notifications/domain/repositories/notification_repository.dart'
    as _i945;
import 'package:jankuier_mobile/features/notifications/domain/usecases/create_or_update_firebase_token_usecase.dart'
    as _i1020;
import 'package:jankuier_mobile/features/notifications/domain/usecases/get_all_notifications_usecase.dart'
    as _i335;
import 'package:jankuier_mobile/features/notifications/domain/usecases/get_firebase_token_usecase.dart'
    as _i379;
import 'package:jankuier_mobile/features/notifications/domain/usecases/get_notification_by_id_usecase.dart'
    as _i924;
import 'package:jankuier_mobile/features/notifications/presentation/bloc/create_or_update_firebase_token/create_or_update_firebase_token_bloc.dart'
    as _i143;
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_all_notifications/get_all_notifications_bloc.dart'
    as _i884;
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_firebase_token/get_firebase_token_bloc.dart'
    as _i65;
import 'package:jankuier_mobile/features/notifications/presentation/bloc/get_notification_by_id/get_notification_by_id_bloc.dart'
    as _i516;
import 'package:jankuier_mobile/features/product_order/data/datasources/product_order_datasource.dart'
    as _i74;
import 'package:jankuier_mobile/features/product_order/data/repositories/product_order_repository_impl.dart'
    as _i662;
import 'package:jankuier_mobile/features/product_order/domain/repositories/product_order_repository.dart'
    as _i171;
import 'package:jankuier_mobile/features/product_order/domain/usecases/cancel_or_delete_product_order_usecase.dart'
    as _i318;
import 'package:jankuier_mobile/features/product_order/domain/usecases/cancel_order_item_usecase.dart'
    as _i857;
import 'package:jankuier_mobile/features/product_order/domain/usecases/create_product_order_from_cart_usecase.dart'
    as _i170;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_all_product_order_item_status_usecase.dart'
    as _i7;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_all_product_order_status_usecase.dart'
    as _i887;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_order_by_id_usecase.dart'
    as _i923;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_order_items_by_id_usecase.dart'
    as _i647;
import 'package:jankuier_mobile/features/product_order/domain/usecases/get_my_product_orders_usecase.dart'
    as _i993;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_or_delete_product_order/cancel_or_delete_product_order_bloc.dart'
    as _i48;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/cancel_order_item/cancel_order_item_bloc.dart'
    as _i1035;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/create_product_order_from_cart/create_product_order_from_cart_bloc.dart'
    as _i971;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_item_status/get_all_product_order_item_status_bloc.dart'
    as _i1027;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_all_product_order_status/get_all_product_order_status_bloc.dart'
    as _i897;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_by_id/get_my_product_order_by_id_bloc.dart'
    as _i888;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_order_items_by_id/get_my_product_order_items_by_id_bloc.dart'
    as _i367;
import 'package:jankuier_mobile/features/product_order/presentation/bloc/get_my_product_orders/get_my_product_orders_bloc.dart'
    as _i567;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i836;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i221;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i670;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i631;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i443;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i575;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i63;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i1056;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i943;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i380;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i259;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i933;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i190;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i644;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i925;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i729;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i700;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i252;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i341;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i161;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i59.DioClient>(() => _i59.DioClient());
    gh.factory<_i947.KffApiDio>(() => _i947.KffApiDio());
    gh.factory<_i633.KffLeagueApiDio>(() => _i633.KffLeagueApiDio());
    gh.factory<_i176.SotaApiDio>(() => _i176.SotaApiDio());
    gh.factory<_i854.HiveUtils>(() => _i854.HiveUtils());
    gh.singletonAsync<_i530.LocalizationService>(() {
      final i = _i530.LocalizationService();
      return i.initialize().then((_) => i);
    });
    gh.factory<_i100.NewsDSInterface>(() => _i100.NewsDSImpl());
    gh.factory<_i933.TicketonOrderDSInterface>(
        () => _i933.TicketonOrderDSImpl());
    gh.singletonAsync<_i633.ContentRefreshService>(() async =>
        _i633.ContentRefreshService(await getAsync<_i530.LocalizationService>())
          ..initialize());
    gh.factory<_i972.NotificationDSInterface>(() => _i972.NotificationDSImpl());
    gh.factory<_i320.KffLeagueDSInterface>(() => _i320.KffLeagueDSImpl());
    gh.factory<_i259.TicketonDSInterface>(() => _i259.TicketonDSImpl());
    gh.factory<_i644.AuthDSInterface>(() => _i644.AuthDSImpl());
    gh.factory<_i888.CartRepository>(
        () => _i648.CartRepositoryImpl(gh<_i948.CartDSInterface>()));
    gh.factory<_i644.TicketonOrderRepository>(() =>
        _i943.TicketonOrderRepositoryImpl(
            gh<_i933.TicketonOrderDSInterface>()));
    gh.factory<_i105.KffDSInterface>(() => _i105.KffDSImpl());
    gh.factory<_i16.AddToCartUseCase>(
        () => _i16.AddToCartUseCase(gh<_i888.CartRepository>()));
    gh.factory<_i515.ClearCartUseCase>(
        () => _i515.ClearCartUseCase(gh<_i888.CartRepository>()));
    gh.factory<_i521.GetMyCartUseCase>(
        () => _i521.GetMyCartUseCase(gh<_i888.CartRepository>()));
    gh.factory<_i876.UpdateCartItemUseCase>(
        () => _i876.UpdateCartItemUseCase(gh<_i888.CartRepository>()));
    gh.factory<_i858.NewsInterface>(
        () => _i80.NewsRepository(gh<_i100.NewsDSInterface>()));
    gh.factory<_i190.TicketonInterface>(
        () => _i380.TicketonRepositoryImpl(gh<_i259.TicketonDSInterface>()));
    gh.factory<_i836.TaskRemoteDataSource>(
        () => _i836.TaskRemoteDataSourceImpl(gh<_i59.DioClient>()));
    gh.factory<_i904.GetNewsFromKffCase>(
        () => _i904.GetNewsFromKffCase(gh<_i858.NewsInterface>()));
    gh.factory<_i904.GetNewsFromKffLeagueCase>(
        () => _i904.GetNewsFromKffLeagueCase(gh<_i858.NewsInterface>()));
    gh.factory<_i92.GetNewOneFromKffCase>(
        () => _i92.GetNewOneFromKffCase(gh<_i858.NewsInterface>()));
    gh.factory<_i92.GetNewOneFromKffLeagueCase>(
        () => _i92.GetNewOneFromKffLeagueCase(gh<_i858.NewsInterface>()));
    gh.factory<_i209.KffInterface>(
        () => _i390.KffRepository(gh<_i105.KffDSInterface>()));
    gh.factory<_i945.NotificationRepository>(() =>
        _i720.NotificationRepositoryImpl(gh<_i972.NotificationDSInterface>()));
    gh.factory<_i821.BookingFieldPartyRepository>(() =>
        _i350.BookingFieldPartyRepositoryImpl(
            gh<_i335.BookingFieldPartyDSInterface>()));
    gh.factory<_i915.AddToCartBloc>(
        () => _i915.AddToCartBloc(gh<_i16.AddToCartUseCase>()));
    gh.factory<_i104.GetAllLeagueCase>(
        () => _i104.GetAllLeagueCase(gh<_i209.KffInterface>()));
    gh.factory<_i272.GetCoachesCase>(
        () => _i272.GetCoachesCase(gh<_i209.KffInterface>()));
    gh.factory<_i681.GetFutureMatchesCase>(
        () => _i681.GetFutureMatchesCase(gh<_i209.KffInterface>()));
    gh.factory<_i81.GetOneLeagueCase>(
        () => _i81.GetOneLeagueCase(gh<_i209.KffInterface>()));
    gh.factory<_i768.GetPastMatchesCase>(
        () => _i768.GetPastMatchesCase(gh<_i209.KffInterface>()));
    gh.factory<_i631.GetPlayersCase>(
        () => _i631.GetPlayersCase(gh<_i209.KffInterface>()));
    gh.factory<_i570.MainSelectionService>(
        () => _i570.MainSelectionService(gh<_i854.HiveUtils>()));
    gh.factory<_i1020.CreateOrUpdateFirebaseTokenUseCase>(() =>
        _i1020.CreateOrUpdateFirebaseTokenUseCase(
            gh<_i945.NotificationRepository>()));
    gh.factory<_i335.GetAllNotificationsUseCase>(() =>
        _i335.GetAllNotificationsUseCase(gh<_i945.NotificationRepository>()));
    gh.factory<_i379.GetFirebaseTokenUseCase>(() =>
        _i379.GetFirebaseTokenUseCase(gh<_i945.NotificationRepository>()));
    gh.factory<_i924.GetNotificationByIdUseCase>(() =>
        _i924.GetNotificationByIdUseCase(gh<_i945.NotificationRepository>()));
    gh.factory<_i516.GetNotificationByIdBloc>(() =>
        _i516.GetNotificationByIdBloc(gh<_i924.GetNotificationByIdUseCase>()));
    gh.factory<_i171.ProductOrderRepository>(() =>
        _i662.ProductOrderRepositoryImpl(gh<_i74.ProductOrderDSInterface>()));
    gh.factory<_i670.TaskRepository>(
        () => _i221.TaskRepositoryImpl(gh<_i836.TaskRemoteDataSource>()));
    gh.factory<_i925.GetTicketOrderUseCase>(
        () => _i925.GetTicketOrderUseCase(gh<_i644.TicketonOrderRepository>()));
    gh.factory<_i700.PaginateTicketOrderUseCase>(() =>
        _i700.PaginateTicketOrderUseCase(gh<_i644.TicketonOrderRepository>()));
    gh.factory<_i252.TicketonOrderCheckUseCase>(() =>
        _i252.TicketonOrderCheckUseCase(gh<_i644.TicketonOrderRepository>()));
    gh.factory<_i341.TicketonTicketCheckUseCase>(() =>
        _i341.TicketonTicketCheckUseCase(gh<_i644.TicketonOrderRepository>()));
    gh.factory<_i106.AuthRepository>(
        () => _i580.AuthRepositoryImpl(gh<_i644.AuthDSInterface>()));
    gh.factory<_i514.CreateBookingFieldPartyRequest>(() =>
        _i514.CreateBookingFieldPartyRequest(
            gh<_i821.BookingFieldPartyRepository>()));
    gh.factory<_i1056.DeleteMyFieldPartyRequestById>(() =>
        _i1056.DeleteMyFieldPartyRequestById(
            gh<_i821.BookingFieldPartyRepository>()));
    gh.factory<_i115.GetAllMyFieldPartyRequest>(() =>
        _i115.GetAllMyFieldPartyRequest(
            gh<_i821.BookingFieldPartyRepository>()));
    gh.factory<_i238.GetMyFieldPartyRequestById>(() =>
        _i238.GetMyFieldPartyRequestById(
            gh<_i821.BookingFieldPartyRepository>()));
    gh.factory<_i439.KffLeagueRepository>(
        () => _i422.KffLeagueRepositoryImpl(gh<_i320.KffLeagueDSInterface>()));
    gh.factory<_i65.GetFirebaseTokenBloc>(
        () => _i65.GetFirebaseTokenBloc(gh<_i379.GetFirebaseTokenUseCase>()));
    gh.factory<_i545.GetPastMatchesBloc>(() => _i545.GetPastMatchesBloc(
        getPastMatchesCase: gh<_i768.GetPastMatchesCase>()));
    gh.factory<_i843.GetFutureMatchesBloc>(() => _i843.GetFutureMatchesBloc(
        getFutureMatchesCase: gh<_i681.GetFutureMatchesCase>()));
    gh.factory<_i729.GetTicketonShowsUseCase>(
        () => _i729.GetTicketonShowsUseCase(gh<_i190.TicketonInterface>()));
    gh.factory<_i610.GetOneLeagueBloc>(() =>
        _i610.GetOneLeagueBloc(getOneLeagueCase: gh<_i81.GetOneLeagueCase>()));
    gh.factory<_i745.MyCartBloc>(
        () => _i745.MyCartBloc(gh<_i521.GetMyCartUseCase>()));
    gh.factory<_i771.ClearCartBloc>(
        () => _i771.ClearCartBloc(gh<_i515.ClearCartUseCase>()));
    gh.factory<_i884.GetAllNotificationsBloc>(() =>
        _i884.GetAllNotificationsBloc(gh<_i335.GetAllNotificationsUseCase>()));
    gh.factory<_i843.GetAllMyFieldPartyRequestBloc>(() =>
        _i843.GetAllMyFieldPartyRequestBloc(
            getAllMyFieldPartyRequest: gh<_i115.GetAllMyFieldPartyRequest>()));
    gh.factory<_i190.CreateBookingFieldPartyRequestBloc>(() =>
        _i190.CreateBookingFieldPartyRequestBloc(
            createBookingFieldPartyRequest:
                gh<_i514.CreateBookingFieldPartyRequest>()));
    gh.factory<_i536.DeleteAccountUseCase>(
        () => _i536.DeleteAccountUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i189.DeleteProfilePhotoUseCase>(
        () => _i189.DeleteProfilePhotoUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i477.GetMeUseCase>(
        () => _i477.GetMeUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i391.RefreshTokenUseCase>(
        () => _i391.RefreshTokenUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i398.SendVerifyCodeUseCase>(
        () => _i398.SendVerifyCodeUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i2.SignInUseCase>(
        () => _i2.SignInUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i153.SignUpUseCase>(
        () => _i153.SignUpUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i194.UpdatePasswordUseCase>(
        () => _i194.UpdatePasswordUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i1047.UpdateProfilePhotoUseCase>(
        () => _i1047.UpdateProfilePhotoUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i625.UpdateProfileUseCase>(
        () => _i625.UpdateProfileUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i517.VerifyCodeUseCase>(
        () => _i517.VerifyCodeUseCase(gh<_i106.AuthRepository>()));
    gh.factory<_i449.GetCoachesBloc>(
        () => _i449.GetCoachesBloc(getCoachesCase: gh<_i272.GetCoachesCase>()));
    gh.factory<_i493.UpdateCartItemBloc>(
        () => _i493.UpdateCartItemBloc(gh<_i876.UpdateCartItemUseCase>()));
    gh.factory<_i779.GetAllLeagueBloc>(() =>
        _i779.GetAllLeagueBloc(getAllLeagueCase: gh<_i104.GetAllLeagueCase>()));
    gh.factory<_i111.SignUpBloc>(
        () => _i111.SignUpBloc(gh<_i153.SignUpUseCase>()));
    gh.factory<_i857.CancelOrderItemUseCase>(
        () => _i857.CancelOrderItemUseCase(gh<_i171.ProductOrderRepository>()));
    gh.factory<_i318.CancelOrDeleteProductOrderUseCase>(() =>
        _i318.CancelOrDeleteProductOrderUseCase(
            gh<_i171.ProductOrderRepository>()));
    gh.factory<_i170.CreateProductOrderFromCartUseCase>(() =>
        _i170.CreateProductOrderFromCartUseCase(
            gh<_i171.ProductOrderRepository>()));
    gh.factory<_i7.GetAllProductOrderItemStatusUseCase>(() =>
        _i7.GetAllProductOrderItemStatusUseCase(
            gh<_i171.ProductOrderRepository>()));
    gh.factory<_i887.GetAllProductOrderStatusUseCase>(() =>
        _i887.GetAllProductOrderStatusUseCase(
            gh<_i171.ProductOrderRepository>()));
    gh.factory<_i993.GetMyProductOrdersUseCase>(() =>
        _i993.GetMyProductOrdersUseCase(gh<_i171.ProductOrderRepository>()));
    gh.factory<_i923.GetMyProductOrderByIdUseCase>(() =>
        _i923.GetMyProductOrderByIdUseCase(gh<_i171.ProductOrderRepository>()));
    gh.factory<_i647.GetMyProductOrderItemsByIdUseCase>(() =>
        _i647.GetMyProductOrderItemsByIdUseCase(
            gh<_i171.ProductOrderRepository>()));
    gh.factory<_i555.GetNewOneBloc>(() => _i555.GetNewOneBloc(
          GetNewOneFromKffCase: gh<_i92.GetNewOneFromKffCase>(),
          GetNewOneFromKffLeagueCase: gh<_i92.GetNewOneFromKffLeagueCase>(),
        ));
    gh.factory<_i934.UpdateProfilePhotoBloc>(() =>
        _i934.UpdateProfilePhotoBloc(gh<_i1047.UpdateProfilePhotoUseCase>()));
    gh.factory<_i176.UpdatePasswordBloc>(
        () => _i176.UpdatePasswordBloc(gh<_i194.UpdatePasswordUseCase>()));
    gh.factory<_i732.DeleteProfilePhotoBloc>(() =>
        _i732.DeleteProfilePhotoBloc(gh<_i189.DeleteProfilePhotoUseCase>()));
    gh.factory<_i1050.GetPlayersBloc>(() =>
        _i1050.GetPlayersBloc(getPlayersCase: gh<_i631.GetPlayersCase>()));
    gh.factory<_i161.TicketonShowsBloc>(() => _i161.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i729.GetTicketonShowsUseCase>()));
    gh.factory<_i17.DeleteMyFieldPartyRequestByIdBloc>(() =>
        _i17.DeleteMyFieldPartyRequestByIdBloc(
            deleteMyFieldPartyRequestById:
                gh<_i1056.DeleteMyFieldPartyRequestById>()));
    gh.factory<_i971.CreateProductOrderFromCartBloc>(() =>
        _i971.CreateProductOrderFromCartBloc(
            gh<_i170.CreateProductOrderFromCartUseCase>()));
    gh.factory<_i631.CreateTask>(
        () => _i631.CreateTask(gh<_i670.TaskRepository>()));
    gh.factory<_i443.DeleteTask>(
        () => _i443.DeleteTask(gh<_i670.TaskRepository>()));
    gh.factory<_i575.GetTasks>(
        () => _i575.GetTasks(gh<_i670.TaskRepository>()));
    gh.factory<_i63.UpdateTask>(
        () => _i63.UpdateTask(gh<_i670.TaskRepository>()));
    gh.factory<_i349.GetNewsBloc>(() => _i349.GetNewsBloc(
          getNewsFromKffCase: gh<_i904.GetNewsFromKffCase>(),
          getNewsFromKffLeagueCase: gh<_i904.GetNewsFromKffLeagueCase>(),
        ));
    gh.factory<_i143.CreateOrUpdateFirebaseTokenBloc>(() =>
        _i143.CreateOrUpdateFirebaseTokenBloc(
            gh<_i1020.CreateOrUpdateFirebaseTokenUseCase>()));
    gh.factory<_i59.SendVerifyCodeBloc>(
        () => _i59.SendVerifyCodeBloc(gh<_i398.SendVerifyCodeUseCase>()));
    gh.factory<_i738.GetChampionshipsUseCase>(
        () => _i738.GetChampionshipsUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i936.GetChampionshipByIdUseCase>(() =>
        _i936.GetChampionshipByIdUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i52.GetMatchesUseCase>(
        () => _i52.GetMatchesUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i78.GetMatchByIdUseCase>(
        () => _i78.GetMatchByIdUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i135.GetSeasonsUseCase>(
        () => _i135.GetSeasonsUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i1029.GetSeasonByIdUseCase>(
        () => _i1029.GetSeasonByIdUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i446.GetTournamentsUseCase>(
        () => _i446.GetTournamentsUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i970.GetTournamentByIdUseCase>(
        () => _i970.GetTournamentByIdUseCase(gh<_i439.KffLeagueRepository>()));
    gh.factory<_i663.UpdateProfileBloc>(
        () => _i663.UpdateProfileBloc(gh<_i625.UpdateProfileUseCase>()));
    gh.factory<_i347.DeleteAccountBloc>(
        () => _i347.DeleteAccountBloc(gh<_i536.DeleteAccountUseCase>()));
    gh.factory<_i865.VerifyCodeBloc>(
        () => _i865.VerifyCodeBloc(gh<_i517.VerifyCodeUseCase>()));
    gh.factory<_i897.ChampionshipsBloc>(() => _i897.ChampionshipsBloc(
          gh<_i738.GetChampionshipsUseCase>(),
          gh<_i936.GetChampionshipByIdUseCase>(),
        ));
    gh.factory<_i255.SignInBloc>(() => _i255.SignInBloc(
          gh<_i2.SignInUseCase>(),
          gh<_i854.HiveUtils>(),
        ));
    gh.factory<_i897.GetAllProductOrderStatusBloc>(() =>
        _i897.GetAllProductOrderStatusBloc(
            gh<_i887.GetAllProductOrderStatusUseCase>()));
    gh.factory<_i604.RefreshTokenBloc>(() => _i604.RefreshTokenBloc(
          gh<_i391.RefreshTokenUseCase>(),
          gh<_i854.HiveUtils>(),
        ));
    gh.factory<_i1056.TaskBloc>(() => _i1056.TaskBloc(
          getTasks: gh<_i575.GetTasks>(),
          createTask: gh<_i631.CreateTask>(),
          updateTask: gh<_i63.UpdateTask>(),
          deleteTask: gh<_i443.DeleteTask>(),
        ));
    gh.factory<_i52.GetMyFieldPartyRequestByIdBloc>(() =>
        _i52.GetMyFieldPartyRequestByIdBloc(
            getMyFieldPartyRequestById:
                gh<_i238.GetMyFieldPartyRequestById>()));
    gh.factory<_i48.CancelOrDeleteProductOrderBloc>(() =>
        _i48.CancelOrDeleteProductOrderBloc(
            gh<_i318.CancelOrDeleteProductOrderUseCase>()));
    gh.factory<_i278.GetMeBloc>(() => _i278.GetMeBloc(
          gh<_i477.GetMeUseCase>(),
          gh<_i854.HiveUtils>(),
        ));
    gh.factory<_i1027.GetAllProductOrderItemStatusBloc>(() =>
        _i1027.GetAllProductOrderItemStatusBloc(
            gh<_i7.GetAllProductOrderItemStatusUseCase>()));
    gh.factory<_i888.GetMyProductOrderByIdBloc>(() =>
        _i888.GetMyProductOrderByIdBloc(
            gh<_i923.GetMyProductOrderByIdUseCase>()));
    gh.factory<_i1035.CancelOrderItemBloc>(
        () => _i1035.CancelOrderItemBloc(gh<_i857.CancelOrderItemUseCase>()));
    gh.factory<_i367.GetMyProductOrderItemsByIdBloc>(() =>
        _i367.GetMyProductOrderItemsByIdBloc(
            gh<_i647.GetMyProductOrderItemsByIdUseCase>()));
    gh.factory<_i567.GetMyProductOrdersBloc>(() =>
        _i567.GetMyProductOrdersBloc(gh<_i993.GetMyProductOrdersUseCase>()));
    gh.factory<_i1006.SeasonsBloc>(() => _i1006.SeasonsBloc(
          gh<_i135.GetSeasonsUseCase>(),
          gh<_i1029.GetSeasonByIdUseCase>(),
        ));
    gh.factory<_i492.MatchesBloc>(() => _i492.MatchesBloc(
          gh<_i52.GetMatchesUseCase>(),
          gh<_i78.GetMatchByIdUseCase>(),
        ));
    gh.factory<_i313.TournamentsBloc>(() => _i313.TournamentsBloc(
          gh<_i446.GetTournamentsUseCase>(),
          gh<_i970.GetTournamentByIdUseCase>(),
        ));
    return this;
  }
}
