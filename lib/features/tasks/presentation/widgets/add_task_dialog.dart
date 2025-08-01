import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(String title, String description, TaskPriority priority, List<String> tags) onTaskCreated;

  const AddTaskDialog({
    super.key,
    required this.onTaskCreated,
  });

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _tagsController = TextEditingController();
  TaskPriority _selectedPriority = TaskPriority.medium;
  List<String> _tags = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Task'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  hintText: 'Enter task title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Enter task description (optional)',
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TaskPriority>(
                value: _selectedPriority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                ),
                items: TaskPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority,
                    child: Text(priority.displayName),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedPriority = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tagsController,
                decoration: const InputDecoration(
                  labelText: 'Tags',
                  hintText: 'Enter tags separated by commas',
                ),
                onChanged: (value) {
                  setState(() {
                    _tags = value
                        .split(',')
                        .map((tag) => tag.trim())
                        .where((tag) => tag.isNotEmpty)
                        .toList();
                  });
                },
              ),
              if (_tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _tags.map((tag) => Chip(
                    label: Text(tag),
                    onDeleted: () {
                      setState(() {
                        _tags.remove(tag);
                        _tagsController.text = _tags.join(', ');
                      });
                    },
                  )).toList(),
                ),
              ],
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: const Text('Add Task'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onTaskCreated(
        _titleController.text.trim(),
        _descriptionController.text.trim(),
        _selectedPriority,
        _tags,
      );
      Navigator.of(context).pop();
    }
  }
} 