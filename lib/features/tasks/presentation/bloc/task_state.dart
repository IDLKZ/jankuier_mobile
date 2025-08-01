import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {
  const TaskInitial();
}

class TaskLoading extends TaskState {
  const TaskLoading();
}

class TasksLoaded extends TaskState {
  final List<Task> tasks;
  final List<Task> filteredTasks;
  final TaskPriority? currentFilter;
  final String? searchQuery;

  const TasksLoaded({
    required this.tasks,
    required this.filteredTasks,
    this.currentFilter,
    this.searchQuery,
  });

  TasksLoaded copyWith({
    List<Task>? tasks,
    List<Task>? filteredTasks,
    TaskPriority? currentFilter,
    String? searchQuery,
  }) {
    return TasksLoaded(
      tasks: tasks ?? this.tasks,
      filteredTasks: filteredTasks ?? this.filteredTasks,
      currentFilter: currentFilter ?? this.currentFilter,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [tasks, filteredTasks, currentFilter, searchQuery];
}

class TaskError extends TaskState {
  final String message;

  const TaskError(this.message);

  @override
  List<Object?> get props => [message];
}

class TaskCreating extends TaskState {
  const TaskCreating();
}

class TaskCreated extends TaskState {
  final Task task;

  const TaskCreated(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskUpdating extends TaskState {
  const TaskUpdating();
}

class TaskUpdated extends TaskState {
  final Task task;

  const TaskUpdated(this.task);

  @override
  List<Object?> get props => [task];
}

class TaskDeleting extends TaskState {
  const TaskDeleting();
}

class TaskDeleted extends TaskState {
  final String taskId;

  const TaskDeleted(this.taskId);

  @override
  List<Object?> get props => [taskId];
} 