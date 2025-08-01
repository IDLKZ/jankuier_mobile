import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import '../network/dio_client.dart';
import '../../features/tasks/data/datasources/task_remote_data_source.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/create_task.dart';
import '../../features/tasks/domain/usecases/delete_task.dart';
import '../../features/tasks/domain/usecases/get_tasks.dart';
import '../../features/tasks/domain/usecases/update_task.dart';
import '../../features/tasks/presentation/bloc/task_bloc.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Core
  getIt.registerLazySingleton<DioClient>(() => DioClient());

  // Data Sources
  getIt.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(getIt<DioClient>()),
  );

  // Repositories
  getIt.registerLazySingleton<TaskRepository>(
    () => TaskRepositoryImpl(getIt<TaskRemoteDataSource>()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetTasks>(
    () => GetTasks(getIt<TaskRepository>()),
  );
  getIt.registerLazySingleton<CreateTask>(
    () => CreateTask(getIt<TaskRepository>()),
  );
  getIt.registerLazySingleton<UpdateTask>(
    () => UpdateTask(getIt<TaskRepository>()),
  );
  getIt.registerLazySingleton<DeleteTask>(
    () => DeleteTask(getIt<TaskRepository>()),
  );

  // BLoCs
  getIt.registerFactory<TaskBloc>(
    () => TaskBloc(
      getTasks: getIt<GetTasks>(),
      createTask: getIt<CreateTask>(),
      updateTask: getIt<UpdateTask>(),
      deleteTask: getIt<DeleteTask>(),
    ),
  );
} 