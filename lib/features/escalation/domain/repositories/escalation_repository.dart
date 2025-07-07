import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/escalation.dart';

abstract class EscalationRepository {
  Future<Either<Failure, List<Escalation>>> getAllEscalations();
  Future<Either<Failure, void>> createEscalation(Escalation escalation);
  Future<Either<Failure, void>> resolveEscalation(String id);
  Future<Either<Failure, List<Escalation>>> getUnresolvedEscalations();
}