import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/task_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  const TaskListView({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Filter out overdue tasks and sort by priority
    final filteredAndSortedTasks = _filterAndSortTasks(tasks);

    if (filteredAndSortedTasks.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          context.read<TaskBloc>().add(LoadTasks());
        },
        child: const CustomScrollView(
          slivers: [
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.task_alt,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No tasks available',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Pull down to refresh',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<TaskBloc>().add(LoadTasks());
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: filteredAndSortedTasks.length,
        itemBuilder: (context, index) {
          return TaskCard(task: filteredAndSortedTasks[index]);
        },
      ),
    );
  }

  List<Task> _filterAndSortTasks(List<Task> tasks) {
    // Filter out overdue tasks
    final nonOverdueTasks = tasks.where((task) => !task.isOverdue).toList();
    
    // Sort by priority (High -> Medium -> Low -> null)
    nonOverdueTasks.sort((a, b) {
      return _getPriorityOrder(a.priority).compareTo(_getPriorityOrder(b.priority));
    });
    
    return nonOverdueTasks;
  }

  int _getPriorityOrder(String? priority) {
    switch (priority?.toLowerCase()) {
      case 'high':
        return 1;
      case 'medium':
        return 2;
      case 'low':
        return 3;
      default:
        return 4; // null or unknown priorities go last
    }
  }
}