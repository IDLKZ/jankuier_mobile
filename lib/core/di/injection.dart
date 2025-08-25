import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:jankuier_mobile/features/countries/data/datasources/country_datasource.dart';
import 'package:jankuier_mobile/features/countries/data/repositories/country_repository.dart';
import 'package:jankuier_mobile/features/countries/domain/interface/country_interface.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../features/countries/domain/use_cases/get_countries_from_sota_case.dart';
import '../../features/countries/presentation/bloc/get_country_bloc.dart';
import '../../features/tournament/domain/use_cases/get_tournaments_from_sota_case.dart';
import '../../features/tournament/presentation/bloc/get_tournaments/get_tournament_bloc.dart';
import '../../features/tournament/domain/interface/tournament_interface.dart';
import '../../features/tournament/data/datasources/tournament_datasource.dart';
import '../../features/tournament/data/repositories/tournament_repository.dart';
import '../network/dio_client.dart';
import '../../features/tasks/data/datasources/task_remote_data_source.dart';
import '../../features/tasks/data/repositories/task_repository_impl.dart';
import '../../features/tasks/domain/repositories/task_repository.dart';
import '../../features/tasks/domain/usecases/create_task.dart';
import '../../features/tasks/domain/usecases/delete_task.dart';
import '../../features/tasks/domain/usecases/get_tasks.dart';
import '../../features/tasks/domain/usecases/update_task.dart';
import '../../features/tasks/presentation/bloc/task_bloc.dart';
import '../network/sota_dio_client.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // Core
// Регистрируем основной DioClient (ваш существующий)
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  // Регистрируем SotaApiDio (ваш существующий)
  getIt.registerLazySingleton<SotaApiDio>(() => SotaApiDio());
  // Регистрируем Dio экземпляры с именами для удобства
  getIt.registerLazySingleton<Dio>(() => getIt<DioClient>().dio,
      instanceName: 'mainApi');
  getIt.registerLazySingleton<Dio>(() => getIt<SotaApiDio>().dio,
      instanceName: 'sotaApi');

  // Talker
  getIt.registerLazySingleton<Talker>(() => TalkerFlutter.init());
  // Data Sources
  getIt.registerLazySingleton<TaskRemoteDataSource>(
    () => TaskRemoteDataSourceImpl(getIt<DioClient>()),
  );
  //Hive
  getIt.registerLazySingleton<HiveInterface>(() => Hive);
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
  //Country
  getIt.registerLazySingleton(() => GetCountriesFromSotaCase(getIt()));
  getIt.registerLazySingleton<CountryInterface>(
      () => CountryRepository(getIt()));
  getIt.registerLazySingleton<CountryDSInterface>(() => CountryDSImpl());

  //Tournament
  getIt.registerLazySingleton(() => GetTournamentsFromSotaCase(getIt()));
  getIt.registerLazySingleton<TournamentInterface>(
      () => TournamentRepository(getIt()));
  getIt.registerLazySingleton<TournamentDSInterface>(() => TournamentDSImpl());

  // BLoCs
  getIt.registerFactory<TaskBloc>(
    () => TaskBloc(
      getTasks: getIt<GetTasks>(),
      createTask: getIt<CreateTask>(),
      updateTask: getIt<UpdateTask>(),
      deleteTask: getIt<DeleteTask>(),
    ),
  );
  getIt.registerFactory<GetCountryBloc>(
    () => GetCountryBloc(
      getCountriesFromSotaCase: getIt<GetCountriesFromSotaCase>(),
    ),
  );
  getIt.registerFactory<GetTournamentBloc>(
    () => GetTournamentBloc(
      getTournamentsFromSotaCase: getIt<GetTournamentsFromSotaCase>(),
    ),
  );
}
