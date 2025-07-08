import 'package:equatable/equatable.dart';
import 'package:errand_buddy/features/tasks/data/model/assigne_model.dart';

abstract class MembersState extends Equatable {
  const MembersState();
  @override
  List<Object?> get props => [];
}

class MembersInitial extends MembersState {}

class MembersLoading extends MembersState {}

class MembersLoaded extends MembersState {
  final List<MemberWithStats> membersWithStats;
  
  const MembersLoaded(this.membersWithStats);
  
  @override
  List<Object?> get props => [membersWithStats];
}

class MembersError extends MembersState {
  final String message;
  
  const MembersError(this.message);
  
  @override
  List<Object?> get props => [message];
}

class MemberWithStats {
  final AssigneeModel member;
  final MemberStats stats;
  
  const MemberWithStats({
    required this.member,
    required this.stats,
  });
}

class MemberStats {
  final int assignedTaskCount;
  final int completedTaskCount;
  final int overdueTaskCount;
  
  const MemberStats({
    required this.assignedTaskCount,
    required this.completedTaskCount,
    required this.overdueTaskCount,
  });
}