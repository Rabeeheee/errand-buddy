import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class UpdateTask {
  final TaskRepository repository;
  
  UpdateTask(this.repository);
  
  Future<Either<Failure, void>> call(Task task) async {
    return await repository.updateTask(task);
  }
}