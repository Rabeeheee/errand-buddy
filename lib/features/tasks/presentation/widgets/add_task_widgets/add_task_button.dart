// add_task_button.dart
import 'package:flutter/material.dart';

class AddTaskButton extends StatelessWidget {
  final bool isUploading;
  final bool canSubmit;
  final VoidCallback onPressed;

  const AddTaskButton({
    Key? key,
    required this.isUploading,
    required this.canSubmit,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      height: 50,
      child: ElevatedButton(
        onPressed: (canSubmit && !isUploading) ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF4A90E2),
          disabledBackgroundColor: const Color(0xFF4A90E2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: isUploading
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
}