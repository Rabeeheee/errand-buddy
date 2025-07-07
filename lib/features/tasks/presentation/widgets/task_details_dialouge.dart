import 'package:errand_buddy/core/utils/priority_utils.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailsDialog extends StatelessWidget {
  final Task task;

  const TaskDetailsDialog({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    task.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildDetailRow('Description', task.description),
            const SizedBox(height: 12),
            _buildDetailRow('Assigned to', task.assignedToName),
            const SizedBox(height: 12),
            _buildDetailRow('Due Date', _formatDate(task.dueDate)),
            const SizedBox(height: 12),
            _buildDetailRow('Priority', _getPriorityText()),
            const SizedBox(height: 12),
            _buildDetailRow('Status', task.isCompleted ? 'Completed' : 'Pending'),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _toggleTaskStatus(context),
                    child: Text(
                      task.isCompleted ? 'Mark Pending' : 'Mark Complete',
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _deleteTask(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _getPriorityText() {
    switch (task.priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }

  void _toggleTaskStatus(BuildContext context) {
    final taskBloc = context.read<TaskBloc>();
    final updatedTask = task.copyWith(
      isCompleted: !task.isCompleted,
      updatedAt: DateTime.now(),
    );
    taskBloc.add(UpdateTaskEvent(updatedTask));
    Navigator.pop(context);
  }

  void _deleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final taskBloc = context.read<TaskBloc>();
              taskBloc.add(DeleteTaskEvent(task.id));
              Navigator.pop(context); // Close confirmation dialog
              Navigator.pop(context); // Close details dialog
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}