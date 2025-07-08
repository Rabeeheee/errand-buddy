import 'package:errand_buddy/core/utils/priority_utils.dart';
import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
// import 'package:errand_buddy/features/tasks/presentation/widgets/task_details_dialouge.dart';
import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: () => _showTaskDetails(context),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPriorityLabel(),
                    const SizedBox(height: 8),
                    Text(
                      task.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDueDate(),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _buildTaskImage(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityLabel() {
    Color color;
    String text;

    switch (task.priority) {
      case TaskPriority.high:
        color = const Color(0xFFE74C3C);
        text = 'High Priority';
        break;
      case TaskPriority.medium:
        color = const Color(0xFFF39C12);
        text = 'Medium Priority';
        break;
      case TaskPriority.low:
        color = const Color(0xFF27AE60);
        text = 'Low Priority';
        break;
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTaskImage() {
    return Container(
      width: 80,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: _getTaskImage(),
      ),
    );
  }

  Widget _getTaskImage() {
    // Based on task type or title, return appropriate image
    String imagePath = _getImagePathForTask();
    
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey[300],
          child: Icon(
            _getDefaultIcon(),
            color: Colors.grey[600],
            size: 24,
          ),
        );
      },
    );
  }

  String _getImagePathForTask() {
    final title = task.title.toLowerCase();
    
    if (title.contains('grocery') || title.contains('shopping')) {
      return 'assets/images/grocery.jpg';
    } else if (title.contains('bill') || title.contains('pay')) {
      return 'assets/images/bills.jpg';
    } else if (title.contains('laundry') || title.contains('wash')) {
      return 'assets/images/laundry.jpg';
    } else if (title.contains('meeting') || title.contains('work')) {
      return 'assets/images/meeting.jpg';
    } else if (title.contains('exercise') || title.contains('workout')) {
      return 'assets/images/exercise.jpg';
    } else if (title.contains('cooking') || title.contains('cook')) {
      return 'assets/images/cooking.jpg';
    }
    
    return 'assets/images/default_task.jpg';
  }

  IconData _getDefaultIcon() {
    final title = task.title.toLowerCase();
    
    if (title.contains('grocery') || title.contains('shopping')) {
      return Icons.shopping_cart;
    } else if (title.contains('bill') || title.contains('pay')) {
      return Icons.receipt;
    } else if (title.contains('laundry') || title.contains('wash')) {
      return Icons.local_laundry_service;
    } else if (title.contains('meeting') || title.contains('work')) {
      return Icons.work;
    } else if (title.contains('exercise') || title.contains('workout')) {
      return Icons.fitness_center;
    } else if (title.contains('cooking') || title.contains('cook')) {
      return Icons.restaurant;
    }
    
    return Icons.task_alt;
  }

  String _formatDueDate() {
    final now = DateTime.now();
    final difference = task.dueDate.difference(now).inDays;
    
    if (difference == 0) {
      return 'Due: Today';
    } else if (difference == 1) {
      return 'Due: Tomorrow';
    } else if (difference == -1) {
      return 'Due: Yesterday';
    } else if (difference > 1) {
      return 'Due: $difference Days';
    } else {
      return 'Due: ${difference.abs()} Days Ago';
    }
  }

  void _showTaskDetails(BuildContext context) {
    // showDialog(
    //   context: context,
    //   // builder: (context) => TaskDetailsDialog(task: task),
    // );
  }
}