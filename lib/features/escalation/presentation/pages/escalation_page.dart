import 'package:errand_buddy/features/escalation/presentation/widgets/escalation_log_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_state.dart';

class EscalationPage extends StatelessWidget {
  const EscalationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: _buildAppBar(),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TasksLoaded) {
            return _buildContent(state.tasks);
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

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Text(
        'Escalated Tasks',
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
      
    );
  }

  Widget _buildContent(List<Task> tasks) {
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

  

  List<Task> _getEscalatedTasks(List<Task> tasks) {
    return tasks.where((task) => task.isOverdue).toList()
      ..sort((a, b) {
        final aOverdueHours = DateTime.now().difference(a.dueDate).inHours;
        final bOverdueHours = DateTime.now().difference(b.dueDate).inHours;
        return bOverdueHours.compareTo(aOverdueHours); // Sort by most overdue first
      });
  }
}