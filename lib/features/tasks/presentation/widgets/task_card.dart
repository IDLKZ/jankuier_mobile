import 'package:flutter/material.dart';
import '../../../../shared/theme/app_theme.dart';
import '../../domain/entities/task.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback onToggleCompletion;
  final VoidCallback onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleCompletion,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onToggleCompletion,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        decoration: task.isCompleted 
                            ? TextDecoration.lineThrough 
                            : null,
                        color: task.isCompleted 
                            ? Theme.of(context).colorScheme.onSurface.withOpacity(0.6)
                            : null,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              if (task.description.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  task.description,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                    decoration: task.isCompleted 
                        ? TextDecoration.lineThrough 
                        : null,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.getPriorityColor(task.priority).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      task.priority.displayName,
                      style: TextStyle(
                        color: AppTheme.getPriorityColor(task.priority),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  if (task.tags.isNotEmpty) ...[
                    ...task.tags.take(3).map((tag) => Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    )),
                    if (task.tags.length > 3)
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            '+${task.tags.length - 3}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 16,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _formatDate(task.createdAt),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                    ),
                  ),
                  if (task.isCompleted && task.completedAt != null) ...[
                    const SizedBox(width: 16),
                    Icon(
                      Icons.check_circle,
                      size: 16,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Completed ${_formatDate(task.completedAt!)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.green,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes}m ago';
      }
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
} 