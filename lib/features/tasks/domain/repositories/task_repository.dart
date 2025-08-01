import 'package:dartz/dartz.dart' hide Task;
import '../../../../core/errors/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getTasks();
  Future<Either<Failure, Task>> getTaskById(String id);
  Future<Either<Failure, Task>> createTask(Task task);
  Future<Either<Failure, Task>> updateTask(Task task);
  Future<Either<Failure, void>> deleteTask(String id);
  Future<Either<Failure, List<Task>>> getTasksByPriority(TaskPriority priority);
  Future<Either<Failure, List<Task>>> searchTasks(String query);
} 