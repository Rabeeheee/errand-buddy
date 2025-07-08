//APP PACKAGES
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/add_task_app_bar.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/add_task_form.dart';
//IMPORTED PACKAGES
import 'package:flutter/material.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AddTaskAppBar(),
      //ADD TASK FORM WIDGET
      body: const AddTaskForm(),
    );
  }

  
}