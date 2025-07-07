import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TaskAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).colorScheme.primary,
      foregroundColor: Theme.of(context).colorScheme.onPrimary,
      title: const Text(
        'Tasks',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () => context.read<TaskBloc>().add(LoadTasks()),
          tooltip: 'Refresh Tasks',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}