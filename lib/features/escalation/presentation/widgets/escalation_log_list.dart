import 'package:errand_buddy/features/escalation/presentation/widgets/escalation_task_item.dart';
import 'package:flutter/material.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';

class EscalationLogList extends StatelessWidget {
  final List<Task> escalatedTasks;

  const EscalationLogList({
    Key? key,
    required this.escalatedTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (escalatedTasks.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: escalatedTasks.length,
          separatorBuilder: (context, index) => const SizedBox(height: 25),
          itemBuilder: (context, index) {
            final task = escalatedTasks[index];
            return EscalationTaskItem(
              task: task,
              overdueHours: _calculateOverdueHours(task),
            );
          },
        ),
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          const SizedBox(height: 16),
          Text(
            'No Escalated Tasks',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Great! All tasks are on track.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
         
        ],
      ),
    );
  }

 

  int _calculateOverdueHours(Task task) {
    if (!task.isOverdue) return 0;
    return DateTime.now().difference(task.dueDate).inHours;
  }
}