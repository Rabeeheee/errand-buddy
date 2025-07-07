import 'package:equatable/equatable.dart';

class Member extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? avatar;
  final int tasksAssigned;
  final int tasksCompleted;
  final DateTime createdAt;
  
  const Member({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
    required this.tasksAssigned,
    required this.tasksCompleted,
    required this.createdAt,
  });
  
  Member copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    int? tasksAssigned,
    int? tasksCompleted,
    DateTime? createdAt,
  }) {
    return Member(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      tasksAssigned: tasksAssigned ?? this.tasksAssigned,
      tasksCompleted: tasksCompleted ?? this.tasksCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  double get completionRate {
    if (tasksAssigned == 0) return 0.0;
    return (tasksCompleted / tasksAssigned) * 100;
  }
  
  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatar,
        tasksAssigned,
        tasksCompleted,
        createdAt,
      ];
}