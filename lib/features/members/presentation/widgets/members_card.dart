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
          children: [
            // Member Avatar
            CircleAvatar(
              radius: 30,
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
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            
            // Stats
            _buildStatRow(
              label: 'Assigned',
              count: stats.assignedTaskCount,
            ),
            const SizedBox(height: 8),
            _buildStatRow(
              label: 'Completed',
              count: stats.completedTaskCount,
            ),
            const SizedBox(height: 8),
            _buildStatRow(
              label: 'Overdue',
              count: stats.overdueTaskCount,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          count.toString(),
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}