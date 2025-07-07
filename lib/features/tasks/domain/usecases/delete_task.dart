import 'package:dartz/dartz.dart' show Either;

import '../../../../core/errors/failures.dart';
import '../repositories/task_repository.dart';

class DeleteTask {
  final TaskRepository repository;
  
  DeleteTask(this.repository);
  
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteTask(id);
  }
}