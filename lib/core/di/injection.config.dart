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
    as _i7;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i5;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i6;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i9;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i8;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i10;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i11;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i12;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i13;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i14;

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
    gh.factory<_i6.TaskRemoteDataSource>(
        () => _i6.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i7.MainSelectionService>(
        () => _i7.MainSelectionService(gh<_i5.HiveUtils>()));
    gh.factory<_i8.TaskRepository>(
        () => _i9.TaskRepositoryImpl(gh<_i6.TaskRemoteDataSource>()));
    gh.factory<_i10.CreateTask>(
        () => _i10.CreateTask(gh<_i8.TaskRepository>()));
    gh.factory<_i11.DeleteTask>(
        () => _i11.DeleteTask(gh<_i8.TaskRepository>()));
    gh.factory<_i12.GetTasks>(() => _i12.GetTasks(gh<_i8.TaskRepository>()));
    gh.factory<_i13.UpdateTask>(
        () => _i13.UpdateTask(gh<_i8.TaskRepository>()));
    gh.factory<_i14.TaskBloc>(() => _i14.TaskBloc(
          getTasks: gh<_i12.GetTasks>(),
          createTask: gh<_i10.CreateTask>(),
          updateTask: gh<_i13.UpdateTask>(),
          deleteTask: gh<_i11.DeleteTask>(),
        ));
    return this;
  }
}
