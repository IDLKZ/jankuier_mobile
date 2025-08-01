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
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i4;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i6;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i5;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i7;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i8;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i9;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i10;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i11;

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
    gh.factory<_i4.TaskRemoteDataSource>(
        () => _i4.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i5.TaskRepository>(
        () => _i6.TaskRepositoryImpl(gh<_i4.TaskRemoteDataSource>()));
    gh.factory<_i7.CreateTask>(() => _i7.CreateTask(gh<_i5.TaskRepository>()));
    gh.factory<_i8.DeleteTask>(() => _i8.DeleteTask(gh<_i5.TaskRepository>()));
    gh.factory<_i9.GetTasks>(() => _i9.GetTasks(gh<_i5.TaskRepository>()));
    gh.factory<_i10.UpdateTask>(
        () => _i10.UpdateTask(gh<_i5.TaskRepository>()));
    gh.factory<_i11.TaskBloc>(() => _i11.TaskBloc(
          getTasks: gh<_i9.GetTasks>(),
          createTask: gh<_i7.CreateTask>(),
          updateTask: gh<_i10.UpdateTask>(),
          deleteTask: gh<_i8.DeleteTask>(),
        ));
    return this;
  }
}
