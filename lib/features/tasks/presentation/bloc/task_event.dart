import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class LoadTasks extends TaskEvent {
  const LoadTasks();
}

class CreateTaskEvent extends TaskEvent {
  final String title;
  final String description;
  final TaskPriority priority;
  final List<String> tags;

  const CreateTaskEvent({
    required this.title,
    required this.description,
    this.priority = TaskPriority.medium,
    this.tags = const [],
  });

  @override
  List<Object?> get props => [title, description, priority, tags];
}

class UpdateTaskEvent extends TaskEvent {
  final Task task;

  const UpdateTaskEvent(this.task);

  @override
  List<Object?> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  const DeleteTaskEvent(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class ToggleTaskCompletion extends TaskEvent {
  final String taskId;

  const ToggleTaskCompletion(this.taskId);

  @override
  List<Object?> get props => [taskId];
}

class FilterTasksByPriority extends TaskEvent {
  final TaskPriority? priority;

  const FilterTasksByPriority(this.priority);

  @override
  List<Object?> get props => [priority];
}

class SearchTasks extends TaskEvent {
  final String query;

  const SearchTasks(this.query);

  @override
  List<Object?> get props => [query];
}

class ClearSearch extends TaskEvent {
  const ClearSearch();
} 