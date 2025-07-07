import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errand_buddy/features/tasks/data/model/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTaskById(String id);
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<List<TaskModel>> getTasksByAssignee(String assigneeId);
  Future<List<TaskModel>> getOverdueTasks();
}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;
  
  TaskRemoteDataSourceImpl({required this.firestore});
  
  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final querySnapshot = await firestore
          .collection('tasks')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get tasks: $e');
    }
  }
  
  @override
  Future<TaskModel> getTaskById(String id) async {
    try {
      final doc = await firestore.collection('tasks').doc(id).get();
      if (!doc.exists) {
        throw Exception('Task not found');
      }
      return TaskModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get task: $e');
    }
  }
  
  @override
  Future<void> createTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').add(task.toFirestore());
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }
  
  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await firestore
          .collection('tasks')
          .doc(task.id)
          .update(task.toFirestore());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }
  
  @override
  Future<void> deleteTask(String id) async {
    try {
      await firestore.collection('tasks').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
  
  @override
  Future<List<TaskModel>> getTasksByAssignee(String assigneeId) async {
    try {
      final querySnapshot = await firestore
          .collection('tasks')
          .where('assignedTo', isEqualTo: assigneeId)
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get tasks by assignee: $e');
    }
  }
  
  @override
  Future<List<TaskModel>> getOverdueTasks() async {
    try {
      final now = DateTime.now();
      final querySnapshot = await firestore
          .collection('tasks')
          .where('dueDate', isLessThan: Timestamp.fromDate(now))
          .where('isCompleted', isEqualTo: false)
          .orderBy('dueDate')
          .get();
      
      return querySnapshot.docs
          .map((doc) => TaskModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get overdue tasks: $e');
    }
  }
}