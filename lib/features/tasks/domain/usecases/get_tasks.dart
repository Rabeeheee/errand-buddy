import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetTasks {
  final TaskRepository repository;
  
  GetTasks(this.repository);
  
  Future<Either<Failure, List<Task>>> call() async {
    return await repository.getAllTasks();
  }
}