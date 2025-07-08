import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/add_title_input.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/assignee_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/due_date_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/priority_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/task_image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:errand_buddy/core/utils/priority_utils.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  TaskPriority _selectedPriority = TaskPriority.low;
  String? _selectedAssigneeId;
  String? _selectedAssigneeName;
  DateTime? _selectedDueDate;
  File? _selectedImage;
  
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: const Text(
        'Add Task',
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TaskTitleInput(
                    controller: _titleController,
                  ),
                  const SizedBox(height: 20),
                  TaskImagePicker(
                    selectedImage: _selectedImage,
                    onImageSelected: (image) {
                      setState(() {
                        _selectedImage = image;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  PrioritySelector(
                    selectedPriority: _selectedPriority,
                    onPrioritySelected: (priority) {
                      setState(() {
                        _selectedPriority = priority;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  AssigneeSelector(
                    selectedAssigneeId: _selectedAssigneeId,
                    selectedAssigneeName: _selectedAssigneeName,
                    onAssigneeSelected: (id, name) {
                      setState(() {
                        _selectedAssigneeId = id;
                        _selectedAssigneeName = name;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  DueDateSelector(
                    selectedDate: _selectedDueDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDueDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
          _buildAddTaskButton(),
        ],
      ),
    );
  }

  Widget _buildAddTaskButton() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      height: 50,
      child: ElevatedButton(
        onPressed: _canSubmit() ? _submitTask : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A90E2),
          disabledBackgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Add Task',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  bool _canSubmit() {
    return _titleController.text.isNotEmpty &&
           _selectedAssigneeId != null &&
           _selectedDueDate != null;
  }

  void _submitTask() {
    if (_formKey.currentState!.validate() && _canSubmit()) {
      final now = DateTime.now();
      final task = Task(
        id: const Uuid().v4(),
        title: _titleController.text.trim(),
        assignedTo: _selectedAssigneeId!,
        assignedToName: _selectedAssigneeName!,
        priority: _selectedPriority,
        dueDate: _selectedDueDate!,
        isCompleted: false,
        createdAt: now,
        updatedAt: now,
        escalationCount: 0,
      );

      context.read<TaskBloc>().add(AddTask(task));
      Navigator.of(context).pop();
    }
  }
}