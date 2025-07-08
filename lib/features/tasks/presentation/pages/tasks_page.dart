import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/task_page_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();
    // Load tasks when the page first loads
    context.read<TaskBloc>().add(LoadTasks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: const TaskScreenBody(),
    );
  }
}