import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/task.dart';

class TaskModel extends Task {
  const TaskModel({
    required super.id,
    required super.title,
    required super.assignedTo,
    required super.assignedToName,
    required super.priority,
    required super.dueDate,
    required super.isCompleted,
    required super.createdAt,
    required super.updatedAt,
    required super.escalationCount,
    super.imageUrl,
  });

  // Factory constructor to create TaskModel from Firestore
  factory TaskModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TaskModel(
      id: doc.id,
      title: data['title'] ?? '',
      assignedTo: data['assignedTo'] ?? '',
      assignedToName: data['assignedToName'] ?? '',
      priority: data['priority'],
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      isCompleted: data['isCompleted'] ?? false,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      escalationCount: data['escalationCount'] ?? 0,
      imageUrl: data['imageUrl'], 
    );
  }

  // Factory constructor to copy from Task entity
  factory TaskModel.fromTask(Task task) {
    return TaskModel(
      id: task.id,
      title: task.title,
      assignedTo: task.assignedTo,
      assignedToName: task.assignedToName,
      priority: task.priority,
      dueDate: task.dueDate,
      isCompleted: task.isCompleted,
      createdAt: task.createdAt,
      updatedAt: task.updatedAt,
      escalationCount: task.escalationCount,
      imageUrl: task.imageUrl, 
    );
  }

  // Convert to Firestore format
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'assignedTo': assignedTo,
      'assignedToName': assignedToName,
      'priority': priority,
      'dueDate': Timestamp.fromDate(dueDate),
      'isCompleted': isCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'escalationCount': escalationCount,
      'imageUrl': imageUrl, 
    };
  }
}
