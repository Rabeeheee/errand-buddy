import 'package:flutter/material.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'escalation_log_list.dart'; // adjust the path if needed

class EscalationContent extends StatelessWidget {
  final List<Task> tasks;

  const EscalationContent({
    Key? key,
    required this.tasks,
  }) : super(key: key);

  List<Task> _getEscalatedTasks(List<Task> tasks) {
    return tasks.where((task) => task.isOverdue).toList();
  }

  @override
  Widget build(BuildContext context) {
    final escalatedTasks = _getEscalatedTasks(tasks);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          EscalationLogList(escalatedTasks: escalatedTasks),
        ],
      ),
    );
  }
}
