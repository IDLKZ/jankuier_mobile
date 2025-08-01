import 'package:equatable/equatable.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime? completedAt;
  final TaskPriority priority;
  final List<String> tags;

  const Task({
    required this.id,
    required this.title,
    required this.description,
    this.isCompleted = false,
    required this.createdAt,
    this.completedAt,
    this.priority = TaskPriority.medium,
    this.tags = const [],
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? completedAt,
    TaskPriority? priority,
    List<String>? tags,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      priority: priority ?? this.priority,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        isCompleted,
        createdAt,
        completedAt,
        priority,
        tags,
      ];
}

enum TaskPriority {
  low,
  medium,
  high,
  urgent;

  String get displayName {
    switch (this) {
      case TaskPriority.low:
        return 'Low';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.high:
        return 'High';
      case TaskPriority.urgent:
        return 'Urgent';
    }
  }

  int get value {
    switch (this) {
      case TaskPriority.low:
        return 1;
      case TaskPriority.medium:
        return 2;
      case TaskPriority.high:
        return 3;
      case TaskPriority.urgent:
        return 4;
    }
  }
} 