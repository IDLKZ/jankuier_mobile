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
import 'package:jankuier_mobile/core/services/main_selection_service.dart'
    as _i31;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i7;
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart'
    as _i12;
import 'package:jankuier_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i39;
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i38;
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i46;
import 'package:jankuier_mobile/features/auth/domain/usecases/send_verify_code_usecase.dart'
    as _i47;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i48;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i49;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart'
    as _i50;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i51;
import 'package:jankuier_mobile/features/auth/domain/usecases/verify_code_usecase.dart'
    as _i52;
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart'
    as _i79;
import 'package:jankuier_mobile/features/auth/presentation/bloc/send_verify_code_bloc/send_verify_code_bloc.dart'
    as _i65;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i77;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart'
    as _i55;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart'
    as _i57;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i74;
import 'package:jankuier_mobile/features/auth/presentation/bloc/verify_code_bloc/verify_code_bloc.dart'
    as _i75;
import 'package:jankuier_mobile/features/blog/data/datasources/news_datasources.dart'
    as _i8;
import 'package:jankuier_mobile/features/blog/data/repositories/news_repository.dart'
    as _i17;
import 'package:jankuier_mobile/features/blog/domain/interface/news_interface.dart'
    as _i16;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_new_one_use_cases.dart'
    as _i22;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_news_use_cases.dart'
    as _i21;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_news/get_news_bloc.dart'
    as _i64;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_single_new/get_new_bloc.dart'
    as _i56;
import 'package:jankuier_mobile/features/kff/data/datasource/kff_datasource.dart'
    as _i15;
import 'package:jankuier_mobile/features/kff/data/repositories/kff_repository.dart'
    as _i24;
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart'
    as _i23;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_all_league_case.dart'
    as _i25;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_coaches_case.dart'
    as _i26;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_future_matches_case.dart'
    as _i27;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_one_league_case.dart'
    as _i28;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_past_matches_case.dart'
    as _i29;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_players_case.dart'
    as _i30;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart'
    as _i54;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_bloc.dart'
    as _i53;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart'
    as _i43;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_one_league/get_one_league_bloc.dart'
    as _i45;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_bloc.dart'
    as _i42;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_players/get_players_bloc.dart'
    as _i58;
import 'package:jankuier_mobile/features/kff_league/data/datasource/kff_league_datasource.dart'
    as _i10;
import 'package:jankuier_mobile/features/kff_league/data/repositories/kff_league_repository_impl.dart'
    as _i41;
import 'package:jankuier_mobile/features/kff_league/domain/repositories/kff_league_repository.dart'
    as _i40;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championship_by_id_usecase.dart'
    as _i67;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_championships_usecase.dart'
    as _i66;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_match_by_id_usecase.dart'
    as _i69;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_matches_usecase.dart'
    as _i68;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_season_by_id_usecase.dart'
    as _i71;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_seasons_usecase.dart'
    as _i70;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournament_by_id_usecase.dart'
    as _i73;
import 'package:jankuier_mobile/features/kff_league/domain/use_cases/get_tournaments_usecase.dart'
    as _i72;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/championships/championships_bloc.dart'
    as _i76;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/matches/matches_bloc.dart'
    as _i81;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/seasons/seasons_bloc.dart'
    as _i80;
import 'package:jankuier_mobile/features/kff_league/presentation/bloc/tournaments/tournaments_bloc.dart'
    as _i82;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i20;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i33;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i32;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i60;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i61;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i62;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i63;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i78;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i14;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i19;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i11;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i9;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i18;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i13;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i34;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i44;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i35;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i36;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i37;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i59;

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
    gh.factory<_i8.NewsDSInterface>(() => _i8.NewsDSImpl());
    gh.factory<_i9.TicketonOrderDSInterface>(() => _i9.TicketonOrderDSImpl());
    gh.factory<_i10.KffLeagueDSInterface>(() => _i10.KffLeagueDSImpl());
    gh.factory<_i11.TicketonDSInterface>(() => _i11.TicketonDSImpl());
    gh.factory<_i12.AuthDSInterface>(() => _i12.AuthDSImpl());
    gh.factory<_i13.TicketonOrderRepository>(() =>
        _i14.TicketonOrderRepositoryImpl(gh<_i9.TicketonOrderDSInterface>()));
    gh.factory<_i15.KffDSInterface>(() => _i15.KffDSImpl());
    gh.factory<_i16.NewsInterface>(
        () => _i17.NewsRepository(gh<_i8.NewsDSInterface>()));
    gh.factory<_i18.TicketonInterface>(
        () => _i19.TicketonRepositoryImpl(gh<_i11.TicketonDSInterface>()));
    gh.factory<_i20.TaskRemoteDataSource>(
        () => _i20.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i21.GetNewsFromKffCase>(
        () => _i21.GetNewsFromKffCase(gh<_i16.NewsInterface>()));
    gh.factory<_i21.GetNewsFromKffLeagueCase>(
        () => _i21.GetNewsFromKffLeagueCase(gh<_i16.NewsInterface>()));
    gh.factory<_i22.GetNewOneFromKffCase>(
        () => _i22.GetNewOneFromKffCase(gh<_i16.NewsInterface>()));
    gh.factory<_i22.GetNewOneFromKffLeagueCase>(
        () => _i22.GetNewOneFromKffLeagueCase(gh<_i16.NewsInterface>()));
    gh.factory<_i23.KffInterface>(
        () => _i24.KffRepository(gh<_i15.KffDSInterface>()));
    gh.factory<_i25.GetAllLeagueCase>(
        () => _i25.GetAllLeagueCase(gh<_i23.KffInterface>()));
    gh.factory<_i26.GetCoachesCase>(
        () => _i26.GetCoachesCase(gh<_i23.KffInterface>()));
    gh.factory<_i27.GetFutureMatchesCase>(
        () => _i27.GetFutureMatchesCase(gh<_i23.KffInterface>()));
    gh.factory<_i28.GetOneLeagueCase>(
        () => _i28.GetOneLeagueCase(gh<_i23.KffInterface>()));
    gh.factory<_i29.GetPastMatchesCase>(
        () => _i29.GetPastMatchesCase(gh<_i23.KffInterface>()));
    gh.factory<_i30.GetPlayersCase>(
        () => _i30.GetPlayersCase(gh<_i23.KffInterface>()));
    gh.factory<_i31.MainSelectionService>(
        () => _i31.MainSelectionService(gh<_i7.HiveUtils>()));
    gh.factory<_i32.TaskRepository>(
        () => _i33.TaskRepositoryImpl(gh<_i20.TaskRemoteDataSource>()));
    gh.factory<_i34.GetTicketOrderUseCase>(
        () => _i34.GetTicketOrderUseCase(gh<_i13.TicketonOrderRepository>()));
    gh.factory<_i35.PaginateTicketOrderUseCase>(() =>
        _i35.PaginateTicketOrderUseCase(gh<_i13.TicketonOrderRepository>()));
    gh.factory<_i36.TicketonOrderCheckUseCase>(() =>
        _i36.TicketonOrderCheckUseCase(gh<_i13.TicketonOrderRepository>()));
    gh.factory<_i37.TicketonTicketCheckUseCase>(() =>
        _i37.TicketonTicketCheckUseCase(gh<_i13.TicketonOrderRepository>()));
    gh.factory<_i38.AuthRepository>(
        () => _i39.AuthRepositoryImpl(gh<_i12.AuthDSInterface>()));
    gh.factory<_i40.KffLeagueRepository>(
        () => _i41.KffLeagueRepositoryImpl(gh<_i10.KffLeagueDSInterface>()));
    gh.factory<_i42.GetPastMatchesBloc>(() => _i42.GetPastMatchesBloc(
        getPastMatchesCase: gh<_i29.GetPastMatchesCase>()));
    gh.factory<_i43.GetFutureMatchesBloc>(() => _i43.GetFutureMatchesBloc(
        getFutureMatchesCase: gh<_i27.GetFutureMatchesCase>()));
    gh.factory<_i44.GetTicketonShowsUseCase>(
        () => _i44.GetTicketonShowsUseCase(gh<_i18.TicketonInterface>()));
    gh.factory<_i45.GetOneLeagueBloc>(() =>
        _i45.GetOneLeagueBloc(getOneLeagueCase: gh<_i28.GetOneLeagueCase>()));
    gh.factory<_i46.GetMeUseCase>(
        () => _i46.GetMeUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i47.SendVerifyCodeUseCase>(
        () => _i47.SendVerifyCodeUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i48.SignInUseCase>(
        () => _i48.SignInUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i49.SignUpUseCase>(
        () => _i49.SignUpUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i50.UpdatePasswordUseCase>(
        () => _i50.UpdatePasswordUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i51.UpdateProfileUseCase>(
        () => _i51.UpdateProfileUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i52.VerifyCodeUseCase>(
        () => _i52.VerifyCodeUseCase(gh<_i38.AuthRepository>()));
    gh.factory<_i53.GetCoachesBloc>(
        () => _i53.GetCoachesBloc(getCoachesCase: gh<_i26.GetCoachesCase>()));
    gh.factory<_i54.GetAllLeagueBloc>(() =>
        _i54.GetAllLeagueBloc(getAllLeagueCase: gh<_i25.GetAllLeagueCase>()));
    gh.factory<_i55.SignUpBloc>(
        () => _i55.SignUpBloc(gh<_i49.SignUpUseCase>()));
    gh.factory<_i56.GetNewOneBloc>(() => _i56.GetNewOneBloc(
          GetNewOneFromKffCase: gh<_i22.GetNewOneFromKffCase>(),
          GetNewOneFromKffLeagueCase: gh<_i22.GetNewOneFromKffLeagueCase>(),
        ));
    gh.factory<_i57.UpdatePasswordBloc>(
        () => _i57.UpdatePasswordBloc(gh<_i50.UpdatePasswordUseCase>()));
    gh.factory<_i58.GetPlayersBloc>(
        () => _i58.GetPlayersBloc(getPlayersCase: gh<_i30.GetPlayersCase>()));
    gh.factory<_i59.TicketonShowsBloc>(() => _i59.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i44.GetTicketonShowsUseCase>()));
    gh.factory<_i60.CreateTask>(
        () => _i60.CreateTask(gh<_i32.TaskRepository>()));
    gh.factory<_i61.DeleteTask>(
        () => _i61.DeleteTask(gh<_i32.TaskRepository>()));
    gh.factory<_i62.GetTasks>(() => _i62.GetTasks(gh<_i32.TaskRepository>()));
    gh.factory<_i63.UpdateTask>(
        () => _i63.UpdateTask(gh<_i32.TaskRepository>()));
    gh.factory<_i64.GetNewsBloc>(() => _i64.GetNewsBloc(
          getNewsFromKffCase: gh<_i21.GetNewsFromKffCase>(),
          getNewsFromKffLeagueCase: gh<_i21.GetNewsFromKffLeagueCase>(),
        ));
    gh.factory<_i65.SendVerifyCodeBloc>(
        () => _i65.SendVerifyCodeBloc(gh<_i47.SendVerifyCodeUseCase>()));
    gh.factory<_i66.GetChampionshipsUseCase>(
        () => _i66.GetChampionshipsUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i67.GetChampionshipByIdUseCase>(
        () => _i67.GetChampionshipByIdUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i68.GetMatchesUseCase>(
        () => _i68.GetMatchesUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i69.GetMatchByIdUseCase>(
        () => _i69.GetMatchByIdUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i70.GetSeasonsUseCase>(
        () => _i70.GetSeasonsUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i71.GetSeasonByIdUseCase>(
        () => _i71.GetSeasonByIdUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i72.GetTournamentsUseCase>(
        () => _i72.GetTournamentsUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i73.GetTournamentByIdUseCase>(
        () => _i73.GetTournamentByIdUseCase(gh<_i40.KffLeagueRepository>()));
    gh.factory<_i74.UpdateProfileBloc>(
        () => _i74.UpdateProfileBloc(gh<_i51.UpdateProfileUseCase>()));
    gh.factory<_i75.VerifyCodeBloc>(
        () => _i75.VerifyCodeBloc(gh<_i52.VerifyCodeUseCase>()));
    gh.factory<_i76.ChampionshipsBloc>(() => _i76.ChampionshipsBloc(
          gh<_i66.GetChampionshipsUseCase>(),
          gh<_i67.GetChampionshipByIdUseCase>(),
        ));
    gh.factory<_i77.SignInBloc>(() => _i77.SignInBloc(
          gh<_i48.SignInUseCase>(),
          gh<_i7.HiveUtils>(),
        ));
    gh.factory<_i78.TaskBloc>(() => _i78.TaskBloc(
          getTasks: gh<_i62.GetTasks>(),
          createTask: gh<_i60.CreateTask>(),
          updateTask: gh<_i63.UpdateTask>(),
          deleteTask: gh<_i61.DeleteTask>(),
        ));
    gh.factory<_i79.GetMeBloc>(() => _i79.GetMeBloc(
          gh<_i46.GetMeUseCase>(),
          gh<_i7.HiveUtils>(),
        ));
    gh.factory<_i80.SeasonsBloc>(() => _i80.SeasonsBloc(
          gh<_i70.GetSeasonsUseCase>(),
          gh<_i71.GetSeasonByIdUseCase>(),
        ));
    gh.factory<_i81.MatchesBloc>(() => _i81.MatchesBloc(
          gh<_i68.GetMatchesUseCase>(),
          gh<_i69.GetMatchByIdUseCase>(),
        ));
    gh.factory<_i82.TournamentsBloc>(() => _i82.TournamentsBloc(
          gh<_i72.GetTournamentsUseCase>(),
          gh<_i73.GetTournamentByIdUseCase>(),
        ));
    return this;
  }
}
