import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

@injectable
class UpdateTask implements UseCase<Task, Task> {
  final TaskRepository repository;

  UpdateTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(Task task) async {
    return await repository.updateTask(task);
  }
} 