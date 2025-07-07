import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/utils/priority_utils.dart';
import '../../domain/entities/task.dart';
import '../bloc/task_bloc.dart';
import '../bloc/task_event.dart';
import '../bloc/task_state.dart';
import '../widgets/task_details_form.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    // Controllers
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    // Use ValueNotifier for local mutable values
    final selectedPriority = ValueNotifier<TaskPriority>(TaskPriority.medium);
    final selectedAssignee = ValueNotifier<String>('John Doe');
    final selectedDate = ValueNotifier<DateTime>(DateTime.now());

    final members = ['John Doe', 'Jane Smith', 'Bob Johnson'];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Add New Task',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.black,
          ),
        ),
      ),
      body: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TasksLoaded) {
            context.pop();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task created successfully')),
            );
          } else if (state is TaskError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder<TaskPriority>(
                    valueListenable: selectedPriority,
                    builder: (_, priority, __) {
                      return ValueListenableBuilder<String>(
                        valueListenable: selectedAssignee,
                        builder: (_, assignee, __) {
                          return ValueListenableBuilder<DateTime>(
                            valueListenable: selectedDate,
                            builder: (_, date, __) {
                              return TaskDetailsForm(
                                titleController: titleController,
                                descriptionController: descriptionController,
                                members: members,
                                selectedPriority: priority,
                                selectedAssignee: assignee,
                                selectedDate: date,
                                onPriorityChanged: (newPriority) => selectedPriority.value = newPriority,
                                onAssigneeChanged: (newAssignee) => selectedAssignee.value = newAssignee,
                                onDateChanged: (newDate) => selectedDate.value = newDate,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
                BlocBuilder<TaskBloc, TaskState>(
                  builder: (context, state) {
                    return CustomButton(
                      text: 'Create Task',
                      isLoading: state is TaskLoading,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final task = Task(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            title: titleController.text,
                            description: descriptionController.text,
                            priority: selectedPriority.value,
                            assignedTo: selectedAssignee.value,
                            assignedToName: '', // Fill if needed
                            dueDate: selectedDate.value,
                            isCompleted: false,
                            createdAt: DateTime.now(),
                            updatedAt: DateTime.now(),
                            escalationCount: 0,
                          );
                          context.read<TaskBloc>().add(AddTask(task));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
