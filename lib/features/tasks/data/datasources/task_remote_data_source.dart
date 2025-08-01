import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/dio_client.dart';
import '../models/task_model.dart';
import '../../domain/entities/task.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getTasks();
  Future<TaskModel> getTaskById(String id);
  Future<TaskModel> createTask(TaskModel task);
  Future<TaskModel> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<List<TaskModel>> getTasksByPriority(TaskPriority priority);
  Future<List<TaskModel>> searchTasks(String query);
}

@Injectable(as: TaskRemoteDataSource)
class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final DioClient _dioClient;

  TaskRemoteDataSourceImpl(this._dioClient);

  // Mock data for demonstration
  final List<TaskModel> _mockTasks = [
    TaskModel(
      id: '1',
      title: 'Complete Flutter project',
      description: 'Finish the mobile app with Clean Architecture',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      priority: TaskPriority.high,
      tags: ['flutter', 'mobile', 'development'],
    ),
    TaskModel(
      id: '2',
      title: 'Review code',
      description: 'Code review for the team project',
      isCompleted: true,
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      completedAt: DateTime.now().subtract(const Duration(hours: 2)),
      priority: TaskPriority.medium,
      tags: ['review', 'team'],
    ),
    TaskModel(
      id: '3',
      title: 'Update documentation',
      description: 'Update API documentation',
      isCompleted: false,
      createdAt: DateTime.now(),
      priority: TaskPriority.low,
      tags: ['documentation', 'api'],
    ),
    TaskModel(
      id: '4',
      title: 'Fix critical bug',
      description: 'Fix the authentication bug in production',
      isCompleted: false,
      createdAt: DateTime.now().subtract(const Duration(hours: 6)),
      priority: TaskPriority.urgent,
      tags: ['bug', 'critical', 'production'],
    ),
  ];

  @override
  Future<List<TaskModel>> getTasks() async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));
      
      // In real implementation, you would make an API call:
      // final response = await _dioClient.dio.get('/tasks');
      // return (response.data as List).map((json) => TaskModel.fromJson(json)).toList();
      
      return _mockTasks;
    } catch (e) {
      throw ServerFailure(message: 'Failed to load tasks: ${e.toString()}');
    }
  }

  @override
  Future<TaskModel> getTaskById(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final task = _mockTasks.firstWhere((task) => task.id == id);
      return task;
    } catch (e) {
      throw ServerFailure(message: 'Task not found: ${e.toString()}');
    }
  }

  @override
  Future<TaskModel> createTask(TaskModel task) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      
      // In real implementation, you would make an API call:
      // final response = await _dioClient.dio.post('/tasks', data: task.toJson());
      // return TaskModel.fromJson(response.data);
      
      _mockTasks.add(task);
      return task;
    } catch (e) {
      throw ServerFailure(message: 'Failed to create task: ${e.toString()}');
    }
  }

  @override
  Future<TaskModel> updateTask(TaskModel task) async {
    try {
      await Future.delayed(const Duration(milliseconds: 400));
      
      final index = _mockTasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _mockTasks[index] = task;
        return task;
      } else {
        throw Exception('Task not found');
      }
    } catch (e) {
      throw ServerFailure(message: 'Failed to update task: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      _mockTasks.removeWhere((task) => task.id == id);
    } catch (e) {
      throw ServerFailure(message: 'Failed to delete task: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskModel>> getTasksByPriority(TaskPriority priority) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      return _mockTasks.where((task) => task.priority == priority).toList();
    } catch (e) {
      throw ServerFailure(message: 'Failed to filter tasks: ${e.toString()}');
    }
  }

  @override
  Future<List<TaskModel>> searchTasks(String query) async {
    try {
      await Future.delayed(const Duration(milliseconds: 300));
      
      final lowercaseQuery = query.toLowerCase();
      return _mockTasks.where((task) =>
        task.title.toLowerCase().contains(lowercaseQuery) ||
        task.description.toLowerCase().contains(lowercaseQuery) ||
        task.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery))
      ).toList();
    } catch (e) {
      throw ServerFailure(message: 'Failed to search tasks: ${e.toString()}');
    }
  }
} 