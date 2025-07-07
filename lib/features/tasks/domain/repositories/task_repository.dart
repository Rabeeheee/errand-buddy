import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure, List<Task>>> getAllTasks();
  Future<Either<Failure, Task>> getTaskById(String id);
  Future<Either<Failure, void>> createTask(Task task);
  Future<Either<Failure, void>> updateTask(Task task);
  Future<Either<Failure, void>> deleteTask(String id);
  Future<Either<Failure, List<Task>>> getTasksByAssignee(String assigneeId);
  Future<Either<Failure, List<Task>>> getOverdueTasks();
  Future<Either<Failure, void>> escalateTask(String taskId);
}