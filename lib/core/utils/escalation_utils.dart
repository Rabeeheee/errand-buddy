// lib/features/escalation/utils/escalation_utils.dart
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';

List<Task> getEscalatedTasks(List<Task> tasks) {
  return tasks.where((task) => task.isOverdue).toList()
    ..sort((a, b) {
      final aOverdueHours = DateTime.now().difference(a.dueDate).inHours;
      final bOverdueHours = DateTime.now().difference(b.dueDate).inHours;
      return bOverdueHours.compareTo(aOverdueHours); // Most overdue first
    });
}
