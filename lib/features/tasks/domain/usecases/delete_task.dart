import 'package:dartz/dartz.dart' hide Task;
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/task_repository.dart';

@injectable
class DeleteTask implements UseCase<void, String> {
  final TaskRepository repository;

  DeleteTask(this.repository);

  @override
  Future<Either<Failure, void>> call(String taskId) async {
    return await repository.deleteTask(taskId);
  }
} 