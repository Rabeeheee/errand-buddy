import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/escalation.dart';
import '../repositories/escalation_repository.dart';

class CreateEscalation {
  final EscalationRepository repository;
  
  CreateEscalation(this.repository);
  
  Future<Either<Failure, void>> call(Escalation escalation) async {
    return await repository.createEscalation(escalation);
  }
}