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
    {'id': '1', 'name': 'Eve', 'avatar': 'assets/images/assignee1.png'},
    {'id': '2', 'name': 'Jane', 'avatar': 'assets/images/assignee2.png'},
    {'id': '3', 'name': 'John', 'avatar': 'assets/images/assignee3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Assignee Field
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedAssigneeName ?? 'Assignee',
                style: TextStyle(
                  fontSize: 16,
                  color: selectedAssigneeName != null ? Colors.black87 : const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: selectedAssigneeName != null ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Assignee List
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAssigneeAvatar(String id, String name, String avatar, bool isSelected) {
    return GestureDetector(
      onTap: () => onAssigneeSelected(id, name),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: isSelected
              ? Border.all(color: const Color(0xFF4A90E2), width: 3)
              : Border.all(color: Colors.white, width: 2),
        ),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: Colors.grey[300],
          backgroundImage:  AssetImage(avatar) ,
          
        ),
      ),
    );
  }

 
}