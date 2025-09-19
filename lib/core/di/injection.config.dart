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
    as _i14;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i5;
import 'package:jankuier_mobile/features/auth/data/datasources/auth_datasource.dart'
    as _i8;
import 'package:jankuier_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i22;
import 'package:jankuier_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i21;
import 'package:jankuier_mobile/features/auth/domain/usecases/get_me_usecase.dart'
    as _i24;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_in_usecase.dart'
    as _i25;
import 'package:jankuier_mobile/features/auth/domain/usecases/sign_up_usecase.dart'
    as _i26;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_password_usecase.dart'
    as _i27;
import 'package:jankuier_mobile/features/auth/domain/usecases/update_profile_usecase.dart'
    as _i28;
import 'package:jankuier_mobile/features/auth/presentation/bloc/get_me_bloc/get_me_bloc.dart'
    as _i39;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_in_bloc/sign_in_bloc.dart'
    as _i37;
import 'package:jankuier_mobile/features/auth/presentation/bloc/sign_up_bloc/sign_up_bloc.dart'
    as _i29;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_password_bloc/update_password_bloc.dart'
    as _i30;
import 'package:jankuier_mobile/features/auth/presentation/bloc/update_profile_bloc/update_profile_bloc.dart'
    as _i36;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i13;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i16;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i15;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i32;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i33;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i34;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i35;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i38;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i10;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i12;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i7;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i6;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i11;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i9;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i17;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i23;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i18;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i19;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i20;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i31;

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
    gh.factory<_i6.TicketonOrderDSInterface>(() => _i6.TicketonOrderDSImpl());
    gh.factory<_i7.TicketonDSInterface>(() => _i7.TicketonDSImpl());
    gh.factory<_i8.AuthDSInterface>(() => _i8.AuthDSImpl());
    gh.factory<_i9.TicketonOrderRepository>(() =>
        _i10.TicketonOrderRepositoryImpl(gh<_i6.TicketonOrderDSInterface>()));
    gh.factory<_i11.TicketonInterface>(
        () => _i12.TicketonRepositoryImpl(gh<_i7.TicketonDSInterface>()));
    gh.factory<_i13.TaskRemoteDataSource>(
        () => _i13.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i14.MainSelectionService>(
        () => _i14.MainSelectionService(gh<_i5.HiveUtils>()));
    gh.factory<_i15.TaskRepository>(
        () => _i16.TaskRepositoryImpl(gh<_i13.TaskRemoteDataSource>()));
    gh.factory<_i17.GetTicketOrderUseCase>(
        () => _i17.GetTicketOrderUseCase(gh<_i9.TicketonOrderRepository>()));
    gh.factory<_i18.PaginateTicketOrderUseCase>(() =>
        _i18.PaginateTicketOrderUseCase(gh<_i9.TicketonOrderRepository>()));
    gh.factory<_i19.TicketonOrderCheckUseCase>(() =>
        _i19.TicketonOrderCheckUseCase(gh<_i9.TicketonOrderRepository>()));
    gh.factory<_i20.TicketonTicketCheckUseCase>(() =>
        _i20.TicketonTicketCheckUseCase(gh<_i9.TicketonOrderRepository>()));
    gh.factory<_i21.AuthRepository>(
        () => _i22.AuthRepositoryImpl(gh<_i8.AuthDSInterface>()));
    gh.factory<_i23.GetTicketonShowsUseCase>(
        () => _i23.GetTicketonShowsUseCase(gh<_i11.TicketonInterface>()));
    gh.factory<_i24.GetMeUseCase>(
        () => _i24.GetMeUseCase(gh<_i21.AuthRepository>()));
    gh.factory<_i25.SignInUseCase>(
        () => _i25.SignInUseCase(gh<_i21.AuthRepository>()));
    gh.factory<_i26.SignUpUseCase>(
        () => _i26.SignUpUseCase(gh<_i21.AuthRepository>()));
    gh.factory<_i27.UpdatePasswordUseCase>(
        () => _i27.UpdatePasswordUseCase(gh<_i21.AuthRepository>()));
    gh.factory<_i28.UpdateProfileUseCase>(
        () => _i28.UpdateProfileUseCase(gh<_i21.AuthRepository>()));
    gh.factory<_i29.SignUpBloc>(
        () => _i29.SignUpBloc(gh<_i26.SignUpUseCase>()));
    gh.factory<_i30.UpdatePasswordBloc>(
        () => _i30.UpdatePasswordBloc(gh<_i27.UpdatePasswordUseCase>()));
    gh.factory<_i31.TicketonShowsBloc>(() => _i31.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i23.GetTicketonShowsUseCase>()));
    gh.factory<_i32.CreateTask>(
        () => _i32.CreateTask(gh<_i15.TaskRepository>()));
    gh.factory<_i33.DeleteTask>(
        () => _i33.DeleteTask(gh<_i15.TaskRepository>()));
    gh.factory<_i34.GetTasks>(() => _i34.GetTasks(gh<_i15.TaskRepository>()));
    gh.factory<_i35.UpdateTask>(
        () => _i35.UpdateTask(gh<_i15.TaskRepository>()));
    gh.factory<_i36.UpdateProfileBloc>(
        () => _i36.UpdateProfileBloc(gh<_i28.UpdateProfileUseCase>()));
    gh.factory<_i37.SignInBloc>(() => _i37.SignInBloc(
          gh<_i25.SignInUseCase>(),
          gh<_i5.HiveUtils>(),
        ));
    gh.factory<_i38.TaskBloc>(() => _i38.TaskBloc(
          getTasks: gh<_i34.GetTasks>(),
          createTask: gh<_i32.CreateTask>(),
          updateTask: gh<_i35.UpdateTask>(),
          deleteTask: gh<_i33.DeleteTask>(),
        ));
    gh.factory<_i39.GetMeBloc>(() => _i39.GetMeBloc(
          gh<_i24.GetMeUseCase>(),
          gh<_i5.HiveUtils>(),
        ));
    return this;
  }
}
