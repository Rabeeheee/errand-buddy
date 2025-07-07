import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/member_model.dart';

abstract class MemberRemoteDataSource {
  Future<List<MemberModel>> getAllMembers();
  Future<MemberModel> getMemberById(String id);
  Future<void> createMember(MemberModel member);
  Future<void> updateMember(MemberModel member);
  Future<void> deleteMember(String id);
}

class MemberRemoteDataSourceImpl implements MemberRemoteDataSource {
  final FirebaseFirestore firestore;
  
  MemberRemoteDataSourceImpl({required this.firestore});
  
  @override
  Future<List<MemberModel>> getAllMembers() async {
    try {
      final querySnapshot = await firestore
          .collection('members')
          .orderBy('createdAt', descending: true)
          .get();
      
      return querySnapshot.docs
          .map((doc) => MemberModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get members: $e');
    }
  }
  
  @override
  Future<MemberModel> getMemberById(String id) async {
    try {
      final doc = await firestore.collection('members').doc(id).get();
      if (!doc.exists) {
        throw Exception('Member not found');
      }
      return MemberModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get member: $e');
    }
  }
  
  @override
  Future<void> createMember(MemberModel member) async {
    try {
      await firestore.collection('members').add(member.toFirestore());
    } catch (e) {
      throw Exception('Failed to create member: $e');
    }
  }
  
  @override
  Future<void> updateMember(MemberModel member) async {
    try {
      await firestore
          .collection('members')
          .doc(member.id)
          .update(member.toFirestore());
    } catch (e) {
      throw Exception('Failed to update member: $e');
    }
  }
  
  @override
  Future<void> deleteMember(String id) async {
    try {
      await firestore.collection('members').doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete member: $e');
    }
  }
}