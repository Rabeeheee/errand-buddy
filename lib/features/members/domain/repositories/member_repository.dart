import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/members.dart';

abstract class MemberRepository {
  Future<Either<Failure, List<Member>>> getAllMembers();
  Future<Either<Failure, Member>> getMemberById(String id);
  Future<Either<Failure, void>> createMember(Member member);
  Future<Either<Failure, void>> updateMember(Member member);
  Future<Either<Failure, void>> deleteMember(String id);
}