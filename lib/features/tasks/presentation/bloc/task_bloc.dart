import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/task.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';
import '../../../../core/usecases/usecase.dart';
import 'task_event.dart';
import 'task_state.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks _getTasks;
  final CreateTask _createTask;
  final UpdateTask _updateTask;
  final DeleteTask _deleteTask;

  TaskBloc({
    required GetTasks getTasks,
    required CreateTask createTask,
    required UpdateTask updateTask,
    required DeleteTask deleteTask,
  })  : _getTasks = getTasks,
        _createTask = createTask,
        _updateTask = updateTask,
        _deleteTask = deleteTask,
        super(const TaskInitial()) {
    on<LoadTasks>(_onLoadTasks);
    on<CreateTaskEvent>(_onCreateTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<ToggleTaskCompletion>(_onToggleTaskCompletion);
    on<FilterTasksByPriority>(_onFilterTasksByPriority);
    on<SearchTasks>(_onSearchTasks);
    on<ClearSearch>(_onClearSearch);
  }

  Future<void> _onLoadTasks(LoadTasks event, Emitter<TaskState> emit) async {
    emit(const TaskLoading());
    
    final result = await _getTasks(const NoParams());
    
    result.fold(
      (failure) => emit(TaskError(failure.message ?? 'Unknown error')),
      (tasks) => emit(TasksLoaded(
        tasks: tasks,
        filteredTasks: tasks,
      )),
    );
  }

  Future<void> _onCreateTask(CreateTaskEvent event, Emitter<TaskState> emit) async {
    emit(const TaskCreating());
    
    final params = CreateTaskParams(
      title: event.title,
      description: event.description,
      priority: event.priority,
      tags: event.tags,
    );
    
    final result = await _createTask(params);
    
    result.fold(
      (failure) => emit(TaskError(failure.message ?? 'Unknown error')),
      (task) {
        emit(TaskCreated(task));
        add(const LoadTasks());
      },
    );
  }

  Future<void> _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(const TaskUpdating());
    
    final result = await _updateTask(event.task);
    
    result.fold(
      (failure) => emit(TaskError(failure.message ?? 'Unknown error')),
      (task) {
        emit(TaskUpdated(task));
        add(const LoadTasks());
      },
    );
  }

  Future<void> _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(const TaskDeleting());
    
    final result = await _deleteTask(event.taskId);
    
    result.fold(
      (failure) => emit(TaskError(failure.message ?? 'Unknown error')),
      (_) {
        emit(TaskDeleted(event.taskId));
        add(const LoadTasks());
      },
    );
  }

  Future<void> _onToggleTaskCompletion(
    ToggleTaskCompletion event,
    Emitter<TaskState> emit,
  ) async {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;
      final task = currentState.tasks.firstWhere((t) => t.id == event.taskId);
      
      final updatedTask = task.copyWith(
        isCompleted: !task.isCompleted,
        completedAt: !task.isCompleted ? DateTime.now() : null,
      );
      
      add(UpdateTaskEvent(updatedTask));
    }
  }

  void _onFilterTasksByPriority(
    FilterTasksByPriority event,
    Emitter<TaskState> emit,
  ) {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;
      List<Task> filteredTasks = currentState.tasks;
      
      if (event.priority != null) {
        filteredTasks = filteredTasks
            .where((task) => task.priority == event.priority)
            .toList();
      }
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        currentFilter: event.priority,
      ));
    }
  }

  void _onSearchTasks(SearchTasks event, Emitter<TaskState> emit) {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;
      List<Task> filteredTasks = currentState.tasks;
      
      if (event.query.isNotEmpty) {
        final lowercaseQuery = event.query.toLowerCase();
        filteredTasks = filteredTasks.where((task) {
          return task.title.toLowerCase().contains(lowercaseQuery) ||
                 task.description.toLowerCase().contains(lowercaseQuery) ||
                 task.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
        }).toList();
      }
      
      emit(currentState.copyWith(
        filteredTasks: filteredTasks,
        searchQuery: event.query.isEmpty ? null : event.query,
      ));
    }
  }

  void _onClearSearch(ClearSearch event, Emitter<TaskState> emit) {
    if (state is TasksLoaded) {
      final currentState = state as TasksLoaded;
      emit(currentState.copyWith(
        filteredTasks: currentState.tasks,
        searchQuery: null,
      ));
    }
  }
} 