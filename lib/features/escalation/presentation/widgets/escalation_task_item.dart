import 'package:flutter/material.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';

class EscalationTaskItem extends StatelessWidget {
  final Task task;
  final int overdueHours;

  const EscalationTaskItem({
    Key? key,
    required this.task,
    required this.overdueHours,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // center vertically
      children: [
        Expanded(child: _buildTaskInfo()),
        _buildOverdueInfo(),
      ],
    );
  }

  Widget _buildTaskInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          task.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          'Originally assigned to ${task.assignedToName}',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildOverdueInfo() {
    return Text(
      _getOverdueText(overdueHours),
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  String _getOverdueText(int hours) {
    if (hours < 24) {
      return 'Overdue by $hours hours';
    } else {
      final days = hours ~/ 24;
      final remainingHours = hours % 24;
      if (remainingHours == 0) {
        return 'Overdue by $days ${days == 1 ? 'day' : 'days'}';
      } else {
        return 'Overdue by $days ${days == 1 ? 'day' : 'days'} ${remainingHours} hours';
      }
    }
  }
}
