import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/members.dart';

class MemberModel extends Member {
  const MemberModel({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required super.tasksAssigned,
    required super.tasksCompleted,
    required super.createdAt,
  });
  
  factory MemberModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MemberModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      avatar: data['avatar'],
      tasksAssigned: data['tasksAssigned'] ?? 0,
      tasksCompleted: data['tasksCompleted'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }
  
  factory MemberModel.fromMember(Member member) {
    return MemberModel(
      id: member.id,
      name: member.name,
      email: member.email,
      avatar: member.avatar,
      tasksAssigned: member.tasksAssigned,
      tasksCompleted: member.tasksCompleted,
      createdAt: member.createdAt,
    );
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'avatar': avatar,
      'tasksAssigned': tasksAssigned,
      'tasksCompleted': tasksCompleted,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
