import 'package:dartz/dartz.dart' show Either, Left, Right;
import 'package:errand_buddy/core/errors/failures.dart';
import 'package:errand_buddy/features/tasks/data/model/task_model.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/task_repository.dart';
import '../datasources/task_remote_data_source.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;
  
  TaskRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, List<Task>>> getAllTasks() async {
    try {
      final tasks = await remoteDataSource.getAllTasks();
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Task>> getTaskById(String id) async {
    try {
      final task = await remoteDataSource.getTaskById(id);
      return Right(task);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> createTask(Task task) async {
    try {
      final taskModel = TaskModel.fromTask(task);
      await remoteDataSource.createTask(taskModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateTask(Task task) async {
    try {
      final taskModel = TaskModel.fromTask(task);
      await remoteDataSource.updateTask(taskModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      await remoteDataSource.deleteTask(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Task>>> getTasksByAssignee(String assigneeId) async {
    try {
      final tasks = await remoteDataSource.getTasksByAssignee(assigneeId);
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Task>>> getOverdueTasks() async {
    try {
      final tasks = await remoteDataSource.getOverdueTasks();
      return Right(tasks);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> escalateTask(String taskId) async {
    try {
      final taskResult = await remoteDataSource.getTaskById(taskId);
      final updatedTask = taskResult.copyWith(
        escalationCount: taskResult.escalationCount + 1,
        updatedAt: DateTime.now(),
      );
      await remoteDataSource.updateTask(TaskModel.fromTask(updatedTask));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
