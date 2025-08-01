import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/task.dart';

part 'task_model.freezed.dart';
part 'task_model.g.dart';

@freezed
class TaskModel with _$TaskModel {
  const factory TaskModel({
    required String id,
    required String title,
    required String description,
    @Default(false) bool isCompleted,
    required DateTime createdAt,
    DateTime? completedAt,
    @Default(TaskPriority.medium) TaskPriority priority,
    @Default([]) List<String> tags,
  }) = _TaskModel;

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  factory TaskModel.fromEntity(Task task) => TaskModel(
        id: task.id,
        title: task.title,
        description: task.description,
        isCompleted: task.isCompleted,
        createdAt: task.createdAt,
        completedAt: task.completedAt,
        priority: task.priority,
        tags: task.tags,
      );
}

extension TaskModelExtension on TaskModel {
  Task toEntity() => Task(
        id: id,
        title: title,
        description: description,
        isCompleted: isCompleted,
        createdAt: createdAt,
        completedAt: completedAt,
        priority: priority,
        tags: tags,
      );
} 