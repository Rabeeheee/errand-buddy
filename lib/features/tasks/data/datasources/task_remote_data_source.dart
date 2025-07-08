import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errand_buddy/features/tasks/data/model/assigne_model.dart';
import 'package:errand_buddy/features/tasks/data/model/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<List<TaskModel>> getAllTasks();
  Future<TaskModel> getTaskById(String id);
  Future<void> createTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String id);
  Future<List<TaskModel>> getTasksByAssignee(String assigneeId);
  Future<List<TaskModel>> getOverdueTasks();
    Future<List<AssigneeModel>> getAllAssignees();

}

class TaskRemoteDataSourceImpl implements TaskRemoteDataSource {
  final FirebaseFirestore firestore;
  
  TaskRemoteDataSourceImpl({required this.firestore});
//GET ALL ASSIGNEES
  @override
  Future<List<AssigneeModel>> getAllAssignees() async {
    try {
      final querySnapshot = await firestore.collection('assignees').get();
      return querySnapshot.docs.map((doc) => AssigneeModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get assignees: $e');
    }
  }
//ADD ASSIGNEES
  Future<void> addAssignee(AssigneeModel assignee) async {
    try {
      await firestore.collection('assignees').add(assignee.toFirestore());
    } catch (e) {
      throw Exception('Failed to add assignee: $e');
    }
  }
//GET ALL TASKS
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
//GET TASK BY ID
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
//CREATE TASK
  @override
  Future<void> createTask(TaskModel task) async {
    try {
      await firestore.collection('tasks').add(task.toFirestore());
    } catch (e) {
      throw Exception('Failed to create task: $e');
    }
  }
//UPDATE TASK
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
//DELETE TASK
  @override
  Future<void> deleteTask(String id) async {
    try {
      await firestore.collection('tasks').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }
//GET TASK BY ASSIGNEE
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
//GET OVERDUE TASK
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