import 'package:errand_buddy/features/tasks/data/model/assigne_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AssigneeSelector extends StatefulWidget {
  final String? selectedAssigneeId;
  final String? selectedAssigneeName;
  final Function(String, String) onAssigneeSelected;

  const AssigneeSelector({
    Key? key,
    required this.selectedAssigneeId,
    required this.selectedAssigneeName,
    required this.onAssigneeSelected,
  }) : super(key: key);

  @override
  State<AssigneeSelector> createState() => _AssigneeSelectorState();
}

class _AssigneeSelectorState extends State<AssigneeSelector> {
  List<AssigneeModel> _assignees = [];

  @override
  void initState() {
    super.initState();
    _loadAssignees();
  }

  Future<void> _loadAssignees() async {
    final querySnapshot = await FirebaseFirestore.instance.collection('assignees').get();
    setState(() {
      _assignees = querySnapshot.docs.map((doc) => AssigneeModel.fromFirestore(doc)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.selectedAssigneeName ?? 'Assignee',
            style: TextStyle(
              fontSize: 16,
              color: widget.selectedAssigneeName != null ? Colors.black87 : Colors.black,
              fontWeight: widget.selectedAssigneeName != null ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _assignees.map((assignee) {
              final isSelected = widget.selectedAssigneeId == assignee.id;
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: GestureDetector(
                  onTap: () => widget.onAssigneeSelected(assignee.id, assignee.name),
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
                      backgroundImage: AssetImage(assignee.avatar),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
