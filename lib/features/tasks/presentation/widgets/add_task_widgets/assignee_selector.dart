import 'package:flutter/material.dart';

class AssigneeSelector extends StatelessWidget {
  final String? selectedAssigneeId;
  final String? selectedAssigneeName;
  final Function(String, String) onAssigneeSelected;

  const AssigneeSelector({
    Key? key,
    required this.selectedAssigneeId,
    required this.selectedAssigneeName,
    required this.onAssigneeSelected,
  }) : super(key: key);

  final List<Map<String, String>> _assignees = const [
    {'id': '1', 'name': 'John Doe', 'avatar': 'https://png.pngtree.com/png-vector/20220709/ourmid/pngtree-businessman-user-avatar-wearing-suit-with-red-tie-png-image_5809521.png'},
    {'id': '2', 'name': 'Jane Smith', 'avatar': 'https://www.google.com/search?q=user+avatar+image&udm=2&sxsrf=AE3TifPqYhbZ8TQvQar7IoKXH41Vabk-rA%3A1751906477971#vhid=46rvAq-TUHLySM&vssid=mosaic'},
    {'id': '3', 'name': 'Mike Johnson', 'avatar': 'https://cdn-icons-png.flaticon.com/512/219/219969.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Assignee',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: _assignees.map((assignee) {
              final isSelected = selectedAssigneeId == assignee['id'];
              return _buildAssigneeAvatar(
                assignee['id']!,
                assignee['name']!,
                assignee['avatar']!,
                isSelected,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAssigneeAvatar(String id, String name, String avatar, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: () => onAssigneeSelected(id, name),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(color: const Color(0xFF4A90E2), width: 3)
                : null,
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[300],
            child: Text(
              name.split(' ').map((e) => e[0]).join().toUpperCase(),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}