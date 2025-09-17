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
    as _i13;
import 'package:jankuier_mobile/core/utils/hive_utils.dart' as _i5;
import 'package:jankuier_mobile/features/tasks/data/datasources/task_remote_data_source.dart'
    as _i12;
import 'package:jankuier_mobile/features/tasks/data/repositories/task_repository_impl.dart'
    as _i15;
import 'package:jankuier_mobile/features/tasks/domain/repositories/task_repository.dart'
    as _i14;
import 'package:jankuier_mobile/features/tasks/domain/usecases/create_task.dart'
    as _i22;
import 'package:jankuier_mobile/features/tasks/domain/usecases/delete_task.dart'
    as _i23;
import 'package:jankuier_mobile/features/tasks/domain/usecases/get_tasks.dart'
    as _i24;
import 'package:jankuier_mobile/features/tasks/domain/usecases/update_task.dart'
    as _i25;
import 'package:jankuier_mobile/features/tasks/presentation/bloc/task_bloc.dart'
    as _i26;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_order_repository_impl.dart'
    as _i9;
import 'package:jankuier_mobile/features/ticket/data/repositories/ticketon_repository_impl.dart'
    as _i11;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_datasource.dart'
    as _i7;
import 'package:jankuier_mobile/features/ticket/datasources/ticketon_order_datasource.dart'
    as _i6;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_interface.dart'
    as _i10;
import 'package:jankuier_mobile/features/ticket/domain/interface/ticketon_order_repository.dart'
    as _i8;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticket_order_usecase.dart'
    as _i16;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/get_ticketon_shows_use_case.dart'
    as _i20;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/paginate_ticket_order_usecase.dart'
    as _i17;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_order_check_usecase.dart'
    as _i18;
import 'package:jankuier_mobile/features/ticket/domain/use_cases/ticketon_ticket_check_usecase.dart'
    as _i19;
import 'package:jankuier_mobile/features/ticket/presentation/bloc/shows/ticketon_bloc.dart'
    as _i21;

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
    gh.factory<_i8.TicketonOrderRepository>(() =>
        _i9.TicketonOrderRepositoryImpl(gh<_i6.TicketonOrderDSInterface>()));
    gh.factory<_i10.TicketonInterface>(
        () => _i11.TicketonRepositoryImpl(gh<_i7.TicketonDSInterface>()));
    gh.factory<_i12.TaskRemoteDataSource>(
        () => _i12.TaskRemoteDataSourceImpl(gh<_i3.DioClient>()));
    gh.factory<_i13.MainSelectionService>(
        () => _i13.MainSelectionService(gh<_i5.HiveUtils>()));
    gh.factory<_i14.TaskRepository>(
        () => _i15.TaskRepositoryImpl(gh<_i12.TaskRemoteDataSource>()));
    gh.factory<_i16.GetTicketOrderUseCase>(
        () => _i16.GetTicketOrderUseCase(gh<_i8.TicketonOrderRepository>()));
    gh.factory<_i17.PaginateTicketOrderUseCase>(() =>
        _i17.PaginateTicketOrderUseCase(gh<_i8.TicketonOrderRepository>()));
    gh.factory<_i18.TicketonOrderCheckUseCase>(() =>
        _i18.TicketonOrderCheckUseCase(gh<_i8.TicketonOrderRepository>()));
    gh.factory<_i19.TicketonTicketCheckUseCase>(() =>
        _i19.TicketonTicketCheckUseCase(gh<_i8.TicketonOrderRepository>()));
    gh.factory<_i20.GetTicketonShowsUseCase>(
        () => _i20.GetTicketonShowsUseCase(gh<_i10.TicketonInterface>()));
    gh.factory<_i21.TicketonShowsBloc>(() => _i21.TicketonShowsBloc(
        getTicketonShowsShowsUseCase: gh<_i20.GetTicketonShowsUseCase>()));
    gh.factory<_i22.CreateTask>(
        () => _i22.CreateTask(gh<_i14.TaskRepository>()));
    gh.factory<_i23.DeleteTask>(
        () => _i23.DeleteTask(gh<_i14.TaskRepository>()));
    gh.factory<_i24.GetTasks>(() => _i24.GetTasks(gh<_i14.TaskRepository>()));
    gh.factory<_i25.UpdateTask>(
        () => _i25.UpdateTask(gh<_i14.TaskRepository>()));
    gh.factory<_i26.TaskBloc>(() => _i26.TaskBloc(
          getTasks: gh<_i24.GetTasks>(),
          createTask: gh<_i22.CreateTask>(),
          updateTask: gh<_i25.UpdateTask>(),
          deleteTask: gh<_i23.DeleteTask>(),
        ));
    return this;
  }
}
