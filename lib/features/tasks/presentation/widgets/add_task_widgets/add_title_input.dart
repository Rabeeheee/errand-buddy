import 'package:flutter/material.dart';

class TaskTitleInput extends StatelessWidget {
  final TextEditingController controller;

  const TaskTitleInput({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          // const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Task Title',
              hintStyle: TextStyle(
                color: Color(0xFF4F7396),
                fontSize: 14,
              ),
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter a task title';
              }
              return null;
            },
          ),
          // const SizedBox(height: 16),
          
        ],
      ),
    );
  }
}