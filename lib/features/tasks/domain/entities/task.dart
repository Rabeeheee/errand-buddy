import 'package:equatable/equatable.dart';
import '../../../../core/utils/priority_utils.dart';

class Task extends Equatable {
  final String id;
  final String title;
  final String assignedTo;
  final String assignedToName;
  final TaskPriority priority;
  final DateTime dueDate;
  final bool isCompleted;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int escalationCount;
  
  const Task({
    required this.id,
    required this.title,
    required this.assignedTo,
    required this.assignedToName,
    required this.priority,
    required this.dueDate,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.escalationCount,
  });
  
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? assignedTo,
    String? assignedToName,
    TaskPriority? priority,
    DateTime? dueDate,
    bool? isCompleted,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? escalationCount,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      escalationCount: escalationCount ?? this.escalationCount,
    );
  }
  
  bool get isOverdue => DateTime.now().isAfter(dueDate) && !isCompleted;
  
  @override
  List<Object?> get props => [
        id,
        title,
        assignedTo,
        assignedToName,
        priority,
        dueDate,
        isCompleted,
        createdAt,
        updatedAt,
        escalationCount,
      ];
}