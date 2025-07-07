import 'package:errand_buddy/features/tasks/presentation/widgets/priority_selector.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/priority_utils.dart'; 
import '../../../../core/widgets/custom_text_field.dart';
import 'date_picker_field.dart';

class TaskDetailsForm extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final List<String> members;
  final String selectedAssignee;
  final DateTime selectedDate;
  final TaskPriority selectedPriority; 
  final Function(String) onAssigneeChanged;
  final Function(DateTime) onDateChanged;
  final Function(TaskPriority) onPriorityChanged; 

  const TaskDetailsForm({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.members,
    required this.selectedAssignee,
    required this.selectedDate,
    required this.selectedPriority,         // ✅ fix here
    required this.onAssigneeChanged,
    required this.onDateChanged,
    required this.onPriorityChanged,        // ✅ fix here
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Task Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              CustomTextField(
                controller: titleController,
                labelText: 'Task Title',
                hintText: 'Enter task title',
                validator: (value) => value!.isEmpty ? 'Please enter title' : null,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: descriptionController,
                labelText: 'Description',
                hintText: 'Enter description',
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              const Text('Priority Level',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              PrioritySelector(
                selectedPriority: selectedPriority,           // ✅ pass current selected value
                onPriorityChanged: onPriorityChanged,         // ✅ pass callback
              ),
              const SizedBox(height: 20),
              const Text('Assign to',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedAssignee,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                items: members.map((member) {
                  return DropdownMenuItem(value: member, child: Text(member));
                }).toList(),
                onChanged: (value) => onAssigneeChanged(value!),
              ),
              const SizedBox(height: 20),
              DatePickerField(
                selectedDate: selectedDate,
                onDateChanged: onDateChanged,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
