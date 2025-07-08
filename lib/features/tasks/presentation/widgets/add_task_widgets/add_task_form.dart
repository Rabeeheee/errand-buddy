import 'package:errand_buddy/core/utils/cloudinary_helper.dart';
import 'package:errand_buddy/features/tasks/presentation/bloc/task_event.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/add_title_input.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/assignee_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/due_date_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/priority_selector.dart';
import 'package:errand_buddy/features/tasks/presentation/widgets/add_task_widgets/task_image_picker.dart';
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
        onPressed: (_canSubmit() && !_isUploading) ? _submitTask : _validateFields,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A90E2),
          disabledBackgroundColor: const Color(0xFF4A90E2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: _isUploading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 2,
              )
            : const Text(
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
    return _titleController.text.trim().isNotEmpty &&
           _selectedAssigneeId != null &&
           _selectedDueDate != null &&
           _selectedPriority != null &&
           _selectedImage != null;
  }

  void _submitTask() async {
    // Check for empty fields and show specific snackbar messages
    if (!_validateFields()) {
      return;
    }

    if (!_formKey.currentState!.validate()) {
      _showSnackBar('Validation Error', 'Please fill in all required fields correctly.');
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

  bool _validateFields() {
    if (_titleController.text.trim().isEmpty) {
      _showSnackBar('Missing Title', 'Please enter a task title.');
      return false;
    }

    if (_selectedImage == null) {
      _showSnackBar('Missing Image', 'Please select an image for the task.');
      return false;
    }

    if (_selectedPriority == null) {
      _showSnackBar('Missing Priority', 'Please select a priority level.');
      return false;
    }

    if (_selectedAssigneeId == null) {
      _showSnackBar('Missing Assignee', 'Please select who will be assigned to this task.');
      return false;
    }

    if (_selectedDueDate == null) {
      _showSnackBar('Missing Due Date', 'Please select a due date for the task.');
      return false;
    }

    return true;
  }

  void _showSnackBar(String title, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$title: $message',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}