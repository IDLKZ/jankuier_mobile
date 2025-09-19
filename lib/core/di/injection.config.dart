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
import 'package:jankuier_mobile/core/network/sota_dio_client.dart' as _i4;
import 'package:jankuier_mobile/core/services/main_selection_service.dart'
    as _i18;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i5;
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart'
    as _i9;
import 'package:jankuier_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i26;
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i25;
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i28;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i29;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i30;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart'
    as _i31;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i32;
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart'
    as _i44;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i42;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart'
    as _i33;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart'
    as _i34;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i41;
import 'package:jankuier_mobile/features/blog/data/datasources/news_datasources.dart'
    as _i6;
import 'package:jankuier_mobile/features/blog/data/repositories/news_repository.dart'
    as _i13;
import 'package:jankuier_mobile/features/blog/domain/interface/news_interface.dart'
    as _i12;
import 'package:jankuier_mobile/features/blog/domain/use_cases/get_news_use_cases.dart'
    as _i17;
import 'package:jankuier_mobile/features/blog/presentation/bloc/get_news/get_news_bloc.dart'
    as _i40;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i16;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i20;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i19;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i36;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i37;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i38;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i39;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i43;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i11;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i15;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i8;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i7;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i14;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i10;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i21;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i27;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i22;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i23;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i24;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i35;

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
    gh.factory<_i4.SotaApiDio>(() => _i4.SotaApiDio());
    gh.factory<_i5.HiveUtils>(() => _i5.HiveUtils());
    gh.factory<_i6.NewsDSInterface>(() => _i6.NewsDSImpl());
    gh.factory<_i7.TicketonOrderDSInterface>(() => _i7.TicketonOrderDSImpl());
    gh.factory<_i8.TicketonDSInterface>(() => _i8.TicketonDSImpl());
    gh.factory<_i9.AuthDSInterface>(() => _i9.AuthDSImpl());
    gh.factory<_i10.TicketonOrderRepository>(() =>
        _i11.TicketonOrderRepositoryImpl(gh<_i7.TicketonOrderDSInterface>()));
    gh.factory<_i12.NewsInterface>(
        () => _i13.NewsRepository(gh<_i6.NewsDSInterface>()));
    gh.factory<_i14.TicketonInterface>(
        () => _i15.TicketonRepositoryImpl(gh<_i8.TicketonDSInterface>()));
    gh.factory<_i16.TaskRemoteDataSource>(
        () => _i16.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i17.GetNewsFromKffCase>(
        () => _i17.GetNewsFromKffCase(gh<_i12.NewsInterface>()));
    gh.factory<_i17.GetNewsFromKffLeagueCase>(
        () => _i17.GetNewsFromKffLeagueCase(gh<_i12.NewsInterface>()));
    gh.factory<_i18.MainSelectionService>(
        () => _i18.MainSelectionService(gh<_i5.HiveUtils>()));
    gh.factory<_i19.TaskRepository>(
        () => _i20.TaskRepositoryImpl(gh<_i16.TaskRemoteDataSource>()));
    gh.factory<_i21.GetTicketOrderUseCase>(
        () => _i21.GetTicketOrderUseCase(gh<_i10.TicketonOrderRepository>()));
    gh.factory<_i22.PaginateTicketOrderUseCase>(() =>
        _i22.PaginateTicketOrderUseCase(gh<_i10.TicketonOrderRepository>()));
    gh.factory<_i23.TicketonOrderCheckUseCase>(() =>
        _i23.TicketonOrderCheckUseCase(gh<_i10.TicketonOrderRepository>()));
    gh.factory<_i24.TicketonTicketCheckUseCase>(() =>
        _i24.TicketonTicketCheckUseCase(gh<_i10.TicketonOrderRepository>()));
    gh.factory<_i25.AuthRepository>(
        () => _i26.AuthRepositoryImpl(gh<_i9.AuthDSInterface>()));
    gh.factory<_i27.GetTicketonShowsUseCase>(
        () => _i27.GetTicketonShowsUseCase(gh<_i14.TicketonInterface>()));
    gh.factory<_i28.GetMeUseCase>(
        () => _i28.GetMeUseCase(gh<_i25.AuthRepository>()));
    gh.factory<_i29.SignInUseCase>(
        () => _i29.SignInUseCase(gh<_i25.AuthRepository>()));
    gh.factory<_i30.SignUpUseCase>(
        () => _i30.SignUpUseCase(gh<_i25.AuthRepository>()));
    gh.factory<_i31.UpdatePasswordUseCase>(
        () => _i31.UpdatePasswordUseCase(gh<_i25.AuthRepository>()));
    gh.factory<_i32.UpdateProfileUseCase>(
        () => _i32.UpdateProfileUseCase(gh<_i25.AuthRepository>()));
    gh.factory<_i33.SignUpBloc>(
        () => _i33.SignUpBloc(gh<_i30.SignUpUseCase>()));
    gh.factory<_i34.UpdatePasswordBloc>(
        () => _i34.UpdatePasswordBloc(gh<_i31.UpdatePasswordUseCase>()));
    gh.factory<_i35.TicketonShowsBloc>(() => _i35.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i27.GetTicketonShowsUseCase>()));
    gh.factory<_i36.CreateTask>(
        () => _i36.CreateTask(gh<_i19.TaskRepository>()));
    gh.factory<_i37.DeleteTask>(
        () => _i37.DeleteTask(gh<_i19.TaskRepository>()));
    gh.factory<_i38.GetTasks>(() => _i38.GetTasks(gh<_i19.TaskRepository>()));
    gh.factory<_i39.UpdateTask>(
        () => _i39.UpdateTask(gh<_i19.TaskRepository>()));
    gh.factory<_i40.GetNewsBloc>(() => _i40.GetNewsBloc(
          getNewsFromKffCase: gh<_i17.GetNewsFromKffCase>(),
          getNewsFromKffLeagueCase: gh<_i17.GetNewsFromKffLeagueCase>(),
        ));
    gh.factory<_i41.UpdateProfileBloc>(
        () => _i41.UpdateProfileBloc(gh<_i32.UpdateProfileUseCase>()));
    gh.factory<_i42.SignInBloc>(() => _i42.SignInBloc(
          gh<_i29.SignInUseCase>(),
          gh<_i5.HiveUtils>(),
        ));
    gh.factory<_i43.TaskBloc>(() => _i43.TaskBloc(
          getTasks: gh<_i38.GetTasks>(),
          createTask: gh<_i36.CreateTask>(),
          updateTask: gh<_i39.UpdateTask>(),
          deleteTask: gh<_i37.DeleteTask>(),
        ));
    gh.factory<_i44.GetMeBloc>(() => _i44.GetMeBloc(
          gh<_i28.GetMeUseCase>(),
          gh<_i5.HiveUtils>(),
        ));
    return this;
  }
}
