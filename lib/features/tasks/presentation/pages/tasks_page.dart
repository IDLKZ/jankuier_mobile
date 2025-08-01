import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/loading_widget.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/task_card.dart';
import '../widgets/add_task_dialog.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  late final TaskBloc _taskBloc;
  final TextEditingController _searchController = TextEditingController();
  TaskPriority? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _taskBloc = GetIt.instance<TaskBloc>();
    _taskBloc.add(const LoadTasks());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: _showSearchDialog,
          ),
          PopupMenuButton<TaskPriority?>(
            icon: const Icon(Icons.filter_list),
            onSelected: (priority) {
              setState(() {
                _selectedPriority = priority;
              });
              _taskBloc.add(FilterTasksByPriority(priority));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: null,
                child: Text('All Priorities'),
              ),
              ...TaskPriority.values.map((priority) => PopupMenuItem(
                value: priority,
                child: Text(priority.displayName),
              )),
            ],
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        bloc: _taskBloc,
        builder: (context, state) {
          if (state is TaskLoading) {
            return const LoadingWidget(message: 'Loading tasks...');
          } else if (state is TaskError) {
            return CustomErrorWidget(
              message: state.message,
              onRetry: () => _taskBloc.add(const LoadTasks()),
            );
          } else if (state is TasksLoaded) {
            if (state.filteredTasks.isEmpty) {
              return _buildEmptyState();
            }
            return _buildTasksList(state.filteredTasks);
          }
          return const LoadingWidget();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTasksList(List<Task> tasks) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: TaskCard(
            task: task,
            onToggleCompletion: () {
              _taskBloc.add(ToggleTaskCompletion(task.id));
            },
            onDelete: () {
              _showDeleteConfirmation(task);
            },
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 64,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Add your first task to get started!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AddTaskDialog(
        onTaskCreated: (title, description, priority, tags) {
          _taskBloc.add(CreateTaskEvent(
            title: title,
            description: description,
            priority: priority,
            tags: tags,
          ));
        },
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search Tasks'),
        content: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Enter search term...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (value) {
            _taskBloc.add(SearchTasks(value));
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              _searchController.clear();
              _taskBloc.add(const ClearSearch());
              Navigator.of(context).pop();
            },
            child: const Text('Clear'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _taskBloc.add(DeleteTaskEvent(task.id));
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
} 