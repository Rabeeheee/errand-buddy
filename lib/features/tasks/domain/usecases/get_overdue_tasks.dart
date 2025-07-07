import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class GetOverdueTasks {
  final TaskRepository repository;
  
  GetOverdueTasks(this.repository);
  
  Future<Either<Failure, List<Task>>> call() async {
    return await repository.getOverdueTasks();
  }
}