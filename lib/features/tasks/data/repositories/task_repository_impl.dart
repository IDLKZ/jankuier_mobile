import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';
import '../models/task_model.dart';

@Injectable(as: TaskRepository)
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource _remoteDataSource;

  TaskRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<Task>>> getTasks() async {
    try {
      final taskModels = await _remoteDataSource.getTasks();
      final tasks = taskModels.map((model) => model.toEntity()).toList();
      return Right(tasks);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> getTaskById(String id) async {
    try {
      final taskModel = await _remoteDataSource.getTaskById(id);
      return Right(taskModel.toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final createdTaskModel = await _remoteDataSource.createTask(taskModel);
      return Right(createdTaskModel.toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromEntity(task);
      final updatedTaskModel = await _remoteDataSource.updateTask(taskModel);
      return Right(updatedTaskModel.toEntity());
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await _remoteDataSource.deleteTask(id);
      return const Right(null);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> getTasksByPriority(TaskPriority priority) async {
    try {
      final taskModels = await _remoteDataSource.getTasksByPriority(priority);
      final tasks = taskModels.map((model) => model.toEntity()).toList();
      return Right(tasks);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Task>>> searchTasks(String query) async {
    try {
      final taskModels = await _remoteDataSource.searchTasks(query);
      final tasks = taskModels.map((model) => model.toEntity()).toList();
      return Right(tasks);
    } on ServerFailure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(UnknownFailure(message: e.toString()));
    }
  }
} 