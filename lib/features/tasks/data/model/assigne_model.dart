import 'package:cloud_firestore/cloud_firestore.dart';

class AssigneeModel {
  final String id;
  final String name;
  final String avatar;

  AssigneeModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory AssigneeModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return AssigneeModel(
      id: doc.id,
      name: data['name'] ?? '',
      avatar: data['avatar'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'avatar': avatar,
    };
  }
}
