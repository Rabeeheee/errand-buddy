import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/members.dart';
import '../repositories/member_repository.dart';

class CreateMember {
  final MemberRepository repository;
  
  CreateMember(this.repository);
  
  Future<Either<Failure, void>> call(Member member) async {
    return await repository.createMember(member);
  }
}