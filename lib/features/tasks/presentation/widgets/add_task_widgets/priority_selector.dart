import 'package:flutter/material.dart';

class PrioritySelector extends StatelessWidget {
  final String? selectedPriority;
  final Function(String) onPrioritySelected;

  const PrioritySelector({
    Key? key,
    this.selectedPriority,
    required this.onPrioritySelected,
  }) : super(key: key);

  // List of priorities
  final List<String> _priorities = const [
    'High',
    'Medium',
    'Low',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Priority Field
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            selectedPriority ?? 'Priority',
            style: TextStyle(
              fontSize: 16,
              color: selectedPriority != null ? Colors.black87 : const Color.fromARGB(255, 0, 0, 0),
              fontWeight: selectedPriority != null ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Priority Chips
        Row(
          children: _priorities.map((priority) {
            return Padding(
              padding: EdgeInsets.only(right: priority != _priorities.last ? 12 : 0),
              child: _buildPriorityChip(priority),
            );
          }).toList(),
        ),
      ],
    );
  }

  // Build each priority chip
  Widget _buildPriorityChip(String priority) {
    final isSelected = selectedPriority == priority;

    return GestureDetector(
      onTap: () => onPrioritySelected(priority),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          priority,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
      ),
    );
  }
}