import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTaskParams {
  final String title;
  final String description;
  final TaskPriority priority;
  final List<String> tags;

  CreateTaskParams({
    required this.title,
    required this.description,
    this.priority = TaskPriority.medium,
    this.tags = const [],
  });
}

@injectable
class CreateTask implements UseCase<Task, CreateTaskParams> {
  final TaskRepository repository;

  CreateTask(this.repository);

  @override
  Future<Either<Failure, Task>> call(CreateTaskParams params) async {
    final task = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: params.title,
      description: params.description,
      priority: params.priority,
      tags: params.tags,
      createdAt: DateTime.now(),
    );
    
    return await repository.createTask(task);
  }
} 