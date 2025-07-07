import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/escalation.dart';
import '../repositories/escalation_repository.dart';

class GetEscalations {
  final EscalationRepository repository;
  
  GetEscalations(this.repository);
  
  Future<Either<Failure, List<Escalation>>> call() async {
    return await repository.getAllEscalations();
  }
}