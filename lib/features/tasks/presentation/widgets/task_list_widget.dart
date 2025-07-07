import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/task_card_widget.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/task_empty_widget.dart';
import 'package:flutter/material.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> tasks;
  final Function(Task) onTaskTap;
  final Function(Task) onTaskUpdate;
  final Function(String) onTaskDelete;
  final bool isOverdueView;

  const TaskListWidget({
    Key? key,
    required this.tasks,
    required this.onTaskTap,
    required this.onTaskUpdate,
    required this.onTaskDelete,
    this.isOverdueView = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return TaskEmptyWidget(
        message: isOverdueView ? 'No overdue tasks' : 'No tasks available',
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: tasks.length,
      separatorBuilder: (context, index) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return TaskCardWidget(
          task: task,
          onTap: () => onTaskTap(task),
          onStatusToggle: () => _toggleTaskStatus(task),
          onDelete: () => _showDeleteConfirmation(context, task),
        );
      },
    );
  }

  void _toggleTaskStatus(Task task) {
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      updatedAt: DateTime.now(),
    );
    onTaskUpdate(updatedTask);
  }

  void _showDeleteConfirmation(BuildContext context, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onTaskDelete(task.id);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}