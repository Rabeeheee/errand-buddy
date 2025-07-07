import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_state.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/task_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskScreenBody extends StatelessWidget {
  const TaskScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskBloc, TaskState>(
      builder: (context, state) {
        if (state is TaskLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4A90E2)),
            ),
          );
        } else if (state is TaskError) {
          return _buildErrorWidget(context, state.message);
        } else if (state is TasksLoaded) {
          return TaskListView(tasks: state.tasks);
        } else if (state is OverdueTasksLoaded) {
          return TaskListView(tasks: state.overdueTasks);
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.read<TaskBloc>().add(LoadTasks()),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}