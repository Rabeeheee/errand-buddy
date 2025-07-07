import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/members.dart';
import '../repositories/member_repository.dart';

class GetMembers {
  final MemberRepository repository;
  
  GetMembers(this.repository);
  
  Future<Either<Failure, List<Member>>> call() async {
    return await repository.getAllMembers();
  }
}