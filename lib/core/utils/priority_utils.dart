import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum TaskPriority { low, medium, high }

class PriorityUtils {
  static Color getColorForPriority(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return AppColors.priorityHigh;
      case TaskPriority.medium:
        return AppColors.priorityMedium;
      case TaskPriority.low:
        return AppColors.priorityLow;
    }
  }
  
  static String getPriorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }
  
  static TaskPriority getPriorityFromString(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return TaskPriority.high;
      case 'medium':
        return TaskPriority.medium;
      case 'low':
        return TaskPriority.low;
      default:
        return TaskPriority.low;
    }
  }
  
  static String getPriorityString(TaskPriority priority) {
    return priority.toString().split('.').last;
  }
}