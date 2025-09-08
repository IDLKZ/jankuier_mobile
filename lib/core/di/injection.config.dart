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
    as _i11;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i6;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i10;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i13;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i12;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i16;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i17;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i18;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i19;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i20;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i9;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i7;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i8;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i14;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i15;

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
    gh.factory<_i6.HiveUtils>(() => _i6.HiveUtils());
    gh.factory<_i7.TicketonDSInterface>(() => _i7.TicketonDSImpl());
    gh.factory<_i8.TicketonInterface>(
        () => _i9.TicketonRepositoryImpl(gh<_i7.TicketonDSInterface>()));
    gh.factory<_i10.TaskRemoteDataSource>(
        () => _i10.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i11.MainSelectionService>(
        () => _i11.MainSelectionService(gh<_i6.HiveUtils>()));
    gh.factory<_i12.TaskRepository>(
        () => _i13.TaskRepositoryImpl(gh<_i10.TaskRemoteDataSource>()));
    gh.factory<_i14.GetTicketonShowsUseCase>(
        () => _i14.GetTicketonShowsUseCase(gh<_i8.TicketonInterface>()));
    gh.factory<_i15.TicketonShowsBloc>(() => _i15.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i14.GetTicketonShowsUseCase>()));
    gh.factory<_i16.CreateTask>(
        () => _i16.CreateTask(gh<_i12.TaskRepository>()));
    gh.factory<_i17.DeleteTask>(
        () => _i17.DeleteTask(gh<_i12.TaskRepository>()));
    gh.factory<_i18.GetTasks>(() => _i18.GetTasks(gh<_i12.TaskRepository>()));
    gh.factory<_i19.UpdateTask>(
        () => _i19.UpdateTask(gh<_i12.TaskRepository>()));
    gh.factory<_i20.TaskBloc>(() => _i20.TaskBloc(
          getTasks: gh<_i18.GetTasks>(),
          createTask: gh<_i16.CreateTask>(),
          updateTask: gh<_i19.UpdateTask>(),
          deleteTask: gh<_i17.DeleteTask>(),
        ));
    return this;
  }
}
