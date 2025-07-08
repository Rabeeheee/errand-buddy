// add_task_form.dart
import 'package:errand_buddy/core/utils/cloudinary_helper.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/add_title_input.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/assignee_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/due_date_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/priority_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/task_image_picker.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/add_task_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_bloc.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';

class AddTaskForm extends StatefulWidget {
  const AddTaskForm({Key? key}) : super(key: key);

  @override
  State<AddTaskForm> createState() => _AddTaskFormState();
}

class _AddTaskFormState extends State<AddTaskForm> {
  final _titleController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  String? _selectedPriority;
  String? _selectedAssigneeId;
  String? _selectedAssigneeName;
  DateTime? _selectedDueDate;
  File? _selectedImage;
  bool _isUploading = false;
  
  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          AddTaskButton(
            isUploading: _isUploading,
            canSubmit: _canSubmit(),
            onPressed: _submitTask,
          ),
        ],
      ),
    );
  }

  bool _canSubmit() {
    return _titleController.text.trim().isNotEmpty &&
           _selectedAssigneeId != null &&
           _selectedDueDate != null &&
           _selectedPriority != null &&
           _selectedImage != null;
  }

  void _submitTask() async {
    if (!_formKey.currentState!.validate()) {
      _showValidationMessage('Please fill in all required fields correctly.');
      return;
    }

    if (!_canSubmit()) {
      _showValidationMessage('Please complete all required fields: Title, Assignee, Due Date, Priority, and Image.');
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final now = DateTime.now();
      String? imageUrl;

      if (_selectedImage != null) {
        imageUrl = await CloudinaryHelper.uploadImage(_selectedImage!);
        
        if (imageUrl == null) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to upload image, but task will be created without image'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        }
      }

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
        imageUrl: imageUrl,
      );

      if (mounted) {
        context.read<TaskBloc>().add(AddTask(task));
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error creating task: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to create task: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  void _showValidationMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.orange,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}