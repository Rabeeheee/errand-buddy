import 'package:errand_buddy/features/tasks/presentation/widgets/task_page_body.dart';
import 'package:flutter/material.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      
      body: const TaskScreenBody(),
    );
  }

}