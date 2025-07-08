//IMPORTED PACKAGES
import 'package:errand_buddy/features/escalation/presentation/widgets/escalation_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//APP PACKAGES
import 'package:errand_buddy/features/escalation/presentation/widgets/escalated_tasks_appbar.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_state.dart';

class EscalationPage extends StatelessWidget {
  const EscalationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      //APP BAR
      appBar: EscalatedTasksAppBar(),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            //CIRCULAR PROGRESS INDICATOR
            return const Center(child: CircularProgressIndicator());
          } else if (state is TasksLoaded) {
            //ESCALATION CONTENT
            return EscalationContent(tasks: state.tasks,);
          } else if (state is TaskError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading tasks',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

 
 

  

  
}