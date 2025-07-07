import 'package:errand_buddy/core/utils/priority_utils.dart';
import 'package:flutter/material.dart';

class TaskPriorityChip extends StatelessWidget {
  final TaskPriority priority;

  const TaskPriorityChip({
    Key? key,
    required this.priority,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _getPriorityColor(context),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        _getPriorityText(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: _getTextColor(context),
        ),
      ),
    );
  }

  Color _getPriorityColor(BuildContext context) {
    switch (priority) {
      case TaskPriority.high:
        return Theme.of(context).colorScheme.error.withOpacity(0.2);
      case TaskPriority.medium:
        return Colors.orange.withOpacity(0.2);
      case TaskPriority.low:
        return Theme.of(context).colorScheme.primary.withOpacity(0.2);
    }
  }

  Color _getTextColor(BuildContext context) {
    switch (priority) {
      case TaskPriority.high:
        return Theme.of(context).colorScheme.error;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.low:
        return Theme.of(context).colorScheme.primary;
    }
  }

  String _getPriorityText() {
    switch (priority) {
      case TaskPriority.high:
        return 'HIGH';
      case TaskPriority.medium:
        return 'MEDIUM';
      case TaskPriority.low:
        return 'LOW';
    }
  }
}