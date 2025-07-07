import 'package:equatable/equatable.dart';

class Escalation extends Equatable {
  final String id;
  final String taskId;
  final String taskTitle;
  final String assignedTo;
  final String assignedToName;
  final DateTime escalatedAt;
  final String reason;
  final bool isResolved;
  final DateTime? resolvedAt;
  
  const Escalation({
    required this.id,
    required this.taskId,
    required this.taskTitle,
    required this.assignedTo,
    required this.assignedToName,
    required this.escalatedAt,
    required this.reason,
    required this.isResolved,
    this.resolvedAt,
  });
  
  Escalation copyWith({
    String? id,
    String? taskId,
    String? taskTitle,
    String? assignedTo,
    String? assignedToName,
    DateTime? escalatedAt,
    String? reason,
    bool? isResolved,
    DateTime? resolvedAt,
  }) {
    return Escalation(
      id: id ?? this.id,
      taskId: taskId ?? this.taskId,
      taskTitle: taskTitle ?? this.taskTitle,
      assignedTo: assignedTo ?? this.assignedTo,
      assignedToName: assignedToName ?? this.assignedToName,
      escalatedAt: escalatedAt ?? this.escalatedAt,
      reason: reason ?? this.reason,
      isResolved: isResolved ?? this.isResolved,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
  
  @override
  List<Object?> get props => [
        id,
        taskId,
        taskTitle,
        assignedTo,
        assignedToName,
        escalatedAt,
        reason,
        isResolved,
        resolvedAt,
      ];
}