import 'package:errand_buddy/features/members/presentation/bloc/member_state.dart';
import 'package:errand_buddy/features/tasks/data/model/assigne_model.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final AssigneeModel member;
  final MemberStats stats;

  const MemberCard({
    super.key,
    required this.member,
    required this.stats,
  });

 @override
Widget build(BuildContext context) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Color(0xffD1DBE8)),
      borderRadius: BorderRadius.circular(10)
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          // Member Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            backgroundImage: AssetImage(member.avatar),
          ),
          const SizedBox(height: 12),
          
          // Member Name
          Text(
            member.name,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.left, // optional
          ),
          const SizedBox(height: 4),
          
          // Stats
          _buildStatRow(
            label: 'Assigned',
            count: stats.assignedTaskCount,
          ),
          const SizedBox(height: 4),
          _buildStatRow(
            label: 'Overdue',
            count: stats.overdueTaskCount,
          ),
          const SizedBox(height: 4),
          
           _buildStatRow(
            label: 'Completed',
            count: stats.completedTaskCount,
          ),
        ],
      ),
    ),
  );
}


  Widget _buildStatRow({
    required String label,
    required int count,
  }) {
    return Row(
      children: [
        Text(
          "$label:",
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        Text(
          "${count.toString()},",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}