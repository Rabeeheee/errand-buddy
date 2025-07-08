import 'package:errand_buddy/features/members/presentation/bloc/member_event.dart';
import 'package:errand_buddy/features/members/presentation/bloc/member_state.dart';
import 'package:errand_buddy/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final TaskRemoteDataSource assigneeDataSource;

  MembersBloc({required this.assigneeDataSource}) : super(MembersInitial()) {
    on<LoadMembers>(_onLoadMembers);
  }

  Future<void> _onLoadMembers(LoadMembers event, Emitter<MembersState> emit) async {
    emit(MembersLoading());
    try {
      final assignees = await assigneeDataSource.getAllAssignees();
      final membersWithStats = <MemberWithStats>[];

      for (final assignee in assignees) {
        final stats = await _getStatsForAssignee(assignee.id);
        membersWithStats.add(MemberWithStats(
          member: assignee,
          stats: stats,
        ));
      }

      emit(MembersLoaded(membersWithStats));
    } catch (e) {
      emit(MembersError(e.toString()));
    }
  }

  Future<MemberStats> _getStatsForAssignee(String assigneeId) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final tasksQuery = firestore
          .collection('tasks')
          .where('assignedTo', isEqualTo: assigneeId);

      final querySnapshot = await tasksQuery.get();
      
      int assignedCount = 0;
      int completedCount = 0;
      int overdueCount = 0;
      final now = DateTime.now();

      for (final doc in querySnapshot.docs) {
        final data = doc.data();
        assignedCount++;
        
        final isCompleted = data['isCompleted'] ?? false;
        if (isCompleted) {
          completedCount++;
        } else {
          final dueDate = (data['dueDate'] as Timestamp).toDate();
          if (now.isAfter(dueDate)) {
            overdueCount++;
          }
        }
      }

      return MemberStats(
        assignedTaskCount: assignedCount,
        completedTaskCount: completedCount,
        overdueTaskCount: overdueCount,
      );
    } catch (e) {
      return MemberStats(
        assignedTaskCount: 0,
        completedTaskCount: 0,
        overdueTaskCount: 0,
      );
    }
  }
}