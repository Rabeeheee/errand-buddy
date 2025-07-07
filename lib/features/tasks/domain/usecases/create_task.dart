import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class CreateTask {
  final TaskRepository repository;
  
  CreateTask(this.repository);
  
  Future<Either<Failure, void>> call(Task task) async {
    return await repository.createTask(task);
  }
}