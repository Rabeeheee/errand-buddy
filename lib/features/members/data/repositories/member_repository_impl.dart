import 'package:dartz/dartz.dart';
import 'package:errand_buddy/core/errors/failures.dart';
import 'package:errand_buddy/features/members/domain/entities/members.dart';
import '../../domain/repositories/member_repository.dart';
import '../datasources/member_remote_data_source.dart';
import '../models/member_model.dart';

class MemberRepositoryImpl implements MemberRepository {
  final MemberRemoteDataSource remoteDataSource;
  
  MemberRepositoryImpl({required this.remoteDataSource});
  
  @override
  Future<Either<Failure, List<Member>>> getAllMembers() async {
    try {
      final members = await remoteDataSource.getAllMembers();
      return Right(members);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, Member>> getMemberById(String id) async {
    try {
      final member = await remoteDataSource.getMemberById(id);
      return Right(member);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> createMember(Member member) async {
    try {
      final memberModel = MemberModel.fromMember(member);
      await remoteDataSource.createMember(memberModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> updateMember(Member member) async {
    try {
      final memberModel = MemberModel.fromMember(member);
      await remoteDataSource.updateMember(memberModel);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteMember(String id) async {
    try {
      await remoteDataSource.deleteMember(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}