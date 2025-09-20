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
import 'package:jankuier_mobile/core/network/sota_dio_client.dart' as _i5;
import 'package:jankuier_mobile/core/services/main_selection_service.dart'
    as _i29;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i6;
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart'
    as _i10;
import 'package:jankuier_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i37;
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i36;
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i42;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i43;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i44;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart'
    as _i45;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i46;
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart'
    as _i62;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i60;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart'
    as _i49;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart'
    as _i51;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i59;
import 'package:jankuier_mobile/features/blog/data/datasources/news_datasources.dart'
    as _i7;
import 'package:jankuier_mobile/features/blog/data/repositories/news_repository.dart'
    as _i15;
import 'package:jankuier_mobile/features/blog/domain/interface/news_interface.dart'
    as _i14;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_new_one_use_cases.dart'
    as _i20;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_news_use_cases.dart'
    as _i19;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_news/get_news_bloc.dart'
    as _i58;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_single_new/get_new_bloc.dart'
    as _i50;
import 'package:jankuier_mobile/features/kff/data/datasource/kff_datasource.dart'
    as _i13;
import 'package:jankuier_mobile/features/kff/data/repositories/kff_repository.dart'
    as _i22;
import 'package:jankuier_mobile/features/kff/domain/interface/kff_interface.dart'
    as _i21;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_all_league_case.dart'
    as _i23;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_coaches_case.dart'
    as _i24;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_future_matches_case.dart'
    as _i25;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_one_league_case.dart'
    as _i26;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_past_matches_case.dart'
    as _i27;
import 'package:jankuier_mobile/features/kff/domain/use_cases/get_players_case.dart'
    as _i28;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_all_league/get_all_league_bloc.dart'
    as _i48;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_coaches/get_coaches_bloc.dart'
    as _i47;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_future_matches/get_future_matches_bloc.dart'
    as _i39;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_one_league/get_one_league_bloc.dart'
    as _i41;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_past_matches/get_past_matches_bloc.dart'
    as _i38;
import 'package:jankuier_mobile/features/kff/presentation/bloc/get_players/get_players_bloc.dart'
    as _i52;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i18;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i31;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i30;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i54;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i55;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i56;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i57;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i61;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i12;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i17;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i9;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i8;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i16;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i11;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i32;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i40;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i33;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i34;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i35;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i53;

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
    gh.factory<_i5.SotaApiDio>(() => _i5.SotaApiDio());
    gh.factory<_i6.HiveUtils>(() => _i6.HiveUtils());
    gh.factory<_i7.NewsDSInterface>(() => _i7.NewsDSImpl());
    gh.factory<_i8.TicketonOrderDSInterface>(() => _i8.TicketonOrderDSImpl());
    gh.factory<_i9.TicketonDSInterface>(() => _i9.TicketonDSImpl());
    gh.factory<_i10.AuthDSInterface>(() => _i10.AuthDSImpl());
    gh.factory<_i11.TicketonOrderRepository>(() =>
        _i12.TicketonOrderRepositoryImpl(gh<_i8.TicketonOrderDSInterface>()));
    gh.factory<_i13.KffDSInterface>(() => _i13.KffDSImpl());
    gh.factory<_i14.NewsInterface>(
        () => _i15.NewsRepository(gh<_i7.NewsDSInterface>()));
    gh.factory<_i16.TicketonInterface>(
        () => _i17.TicketonRepositoryImpl(gh<_i9.TicketonDSInterface>()));
    gh.factory<_i18.TaskRemoteDataSource>(
        () => _i18.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i19.GetNewsFromKffCase>(
        () => _i19.GetNewsFromKffCase(gh<_i14.NewsInterface>()));
    gh.factory<_i19.GetNewsFromKffLeagueCase>(
        () => _i19.GetNewsFromKffLeagueCase(gh<_i14.NewsInterface>()));
    gh.factory<_i20.GetNewOneFromKffCase>(
        () => _i20.GetNewOneFromKffCase(gh<_i14.NewsInterface>()));
    gh.factory<_i20.GetNewOneFromKffLeagueCase>(
        () => _i20.GetNewOneFromKffLeagueCase(gh<_i14.NewsInterface>()));
    gh.factory<_i21.KffInterface>(
        () => _i22.KffRepository(gh<_i13.KffDSInterface>()));
    gh.factory<_i23.GetAllLeagueCase>(
        () => _i23.GetAllLeagueCase(gh<_i21.KffInterface>()));
    gh.factory<_i24.GetCoachesCase>(
        () => _i24.GetCoachesCase(gh<_i21.KffInterface>()));
    gh.factory<_i25.GetFutureMatchesCase>(
        () => _i25.GetFutureMatchesCase(gh<_i21.KffInterface>()));
    gh.factory<_i26.GetOneLeagueCase>(
        () => _i26.GetOneLeagueCase(gh<_i21.KffInterface>()));
    gh.factory<_i27.GetPastMatchesCase>(
        () => _i27.GetPastMatchesCase(gh<_i21.KffInterface>()));
    gh.factory<_i28.GetPlayersCase>(
        () => _i28.GetPlayersCase(gh<_i21.KffInterface>()));
    gh.factory<_i29.MainSelectionService>(
        () => _i29.MainSelectionService(gh<_i6.HiveUtils>()));
    gh.factory<_i30.TaskRepository>(
        () => _i31.TaskRepositoryImpl(gh<_i18.TaskRemoteDataSource>()));
    gh.factory<_i32.GetTicketOrderUseCase>(
        () => _i32.GetTicketOrderUseCase(gh<_i11.TicketonOrderRepository>()));
    gh.factory<_i33.PaginateTicketOrderUseCase>(() =>
        _i33.PaginateTicketOrderUseCase(gh<_i11.TicketonOrderRepository>()));
    gh.factory<_i34.TicketonOrderCheckUseCase>(() =>
        _i34.TicketonOrderCheckUseCase(gh<_i11.TicketonOrderRepository>()));
    gh.factory<_i35.TicketonTicketCheckUseCase>(() =>
        _i35.TicketonTicketCheckUseCase(gh<_i11.TicketonOrderRepository>()));
    gh.factory<_i36.AuthRepository>(
        () => _i37.AuthRepositoryImpl(gh<_i10.AuthDSInterface>()));
    gh.factory<_i38.GetPastMatchesBloc>(() => _i38.GetPastMatchesBloc(
        getPastMatchesCase: gh<_i27.GetPastMatchesCase>()));
    gh.factory<_i39.GetFutureMatchesBloc>(() => _i39.GetFutureMatchesBloc(
        getFutureMatchesCase: gh<_i25.GetFutureMatchesCase>()));
    gh.factory<_i40.GetTicketonShowsUseCase>(
        () => _i40.GetTicketonShowsUseCase(gh<_i16.TicketonInterface>()));
    gh.factory<_i41.GetOneLeagueBloc>(() =>
        _i41.GetOneLeagueBloc(getOneLeagueCase: gh<_i26.GetOneLeagueCase>()));
    gh.factory<_i42.GetMeUseCase>(
        () => _i42.GetMeUseCase(gh<_i36.AuthRepository>()));
    gh.factory<_i43.SignInUseCase>(
        () => _i43.SignInUseCase(gh<_i36.AuthRepository>()));
    gh.factory<_i44.SignUpUseCase>(
        () => _i44.SignUpUseCase(gh<_i36.AuthRepository>()));
    gh.factory<_i45.UpdatePasswordUseCase>(
        () => _i45.UpdatePasswordUseCase(gh<_i36.AuthRepository>()));
    gh.factory<_i46.UpdateProfileUseCase>(
        () => _i46.UpdateProfileUseCase(gh<_i36.AuthRepository>()));
    gh.factory<_i47.GetCoachesBloc>(
        () => _i47.GetCoachesBloc(getCoachesCase: gh<_i24.GetCoachesCase>()));
    gh.factory<_i48.GetAllLeagueBloc>(() =>
        _i48.GetAllLeagueBloc(getAllLeagueCase: gh<_i23.GetAllLeagueCase>()));
    gh.factory<_i49.SignUpBloc>(
        () => _i49.SignUpBloc(gh<_i44.SignUpUseCase>()));
    gh.factory<_i50.GetNewOneBloc>(() => _i50.GetNewOneBloc(
          GetNewOneFromKffCase: gh<_i20.GetNewOneFromKffCase>(),
          GetNewOneFromKffLeagueCase: gh<_i20.GetNewOneFromKffLeagueCase>(),
        ));
    gh.factory<_i51.UpdatePasswordBloc>(
        () => _i51.UpdatePasswordBloc(gh<_i45.UpdatePasswordUseCase>()));
    gh.factory<_i52.GetPlayersBloc>(
        () => _i52.GetPlayersBloc(getPlayersCase: gh<_i28.GetPlayersCase>()));
    gh.factory<_i53.TicketonShowsBloc>(() => _i53.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i40.GetTicketonShowsUseCase>()));
    gh.factory<_i54.CreateTask>(
        () => _i54.CreateTask(gh<_i30.TaskRepository>()));
    gh.factory<_i55.DeleteTask>(
        () => _i55.DeleteTask(gh<_i30.TaskRepository>()));
    gh.factory<_i56.GetTasks>(() => _i56.GetTasks(gh<_i30.TaskRepository>()));
    gh.factory<_i57.UpdateTask>(
        () => _i57.UpdateTask(gh<_i30.TaskRepository>()));
    gh.factory<_i58.GetNewsBloc>(() => _i58.GetNewsBloc(
          getNewsFromKffCase: gh<_i19.GetNewsFromKffCase>(),
          getNewsFromKffLeagueCase: gh<_i19.GetNewsFromKffLeagueCase>(),
        ));
    gh.factory<_i59.UpdateProfileBloc>(
        () => _i59.UpdateProfileBloc(gh<_i46.UpdateProfileUseCase>()));
    gh.factory<_i60.SignInBloc>(() => _i60.SignInBloc(
          gh<_i43.SignInUseCase>(),
          gh<_i6.HiveUtils>(),
        ));
    gh.factory<_i61.TaskBloc>(() => _i61.TaskBloc(
          getTasks: gh<_i56.GetTasks>(),
          createTask: gh<_i54.CreateTask>(),
          updateTask: gh<_i57.UpdateTask>(),
          deleteTask: gh<_i55.DeleteTask>(),
        ));
    gh.factory<_i62.GetMeBloc>(() => _i62.GetMeBloc(
          gh<_i42.GetMeUseCase>(),
          gh<_i6.HiveUtils>(),
        ));
    return this;
  }
}
