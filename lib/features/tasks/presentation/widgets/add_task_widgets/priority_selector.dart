import 'package:flutter/material.dart';
import 'package:errand_buddy/core/utils/priority_utils.dart';

class PrioritySelector extends StatelessWidget {
  final TaskPriority? selectedPriority;
  final Function(TaskPriority) onPrioritySelected;

  const PrioritySelector({
    Key? key,
    required this.selectedPriority,
    required this.onPrioritySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
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
                selectedPriority != null ? _getPriorityLabel(selectedPriority!) : 'Priority',
                style: TextStyle(
                  fontSize: 16,
                  color: selectedPriority != null ? Colors.black87 : Colors.grey[600],
                  fontWeight: selectedPriority != null ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Priority Options
            Row(
              children: [
                _buildPriorityChip(TaskPriority.high, 'High'),
                const SizedBox(width: 12),
                _buildPriorityChip(TaskPriority.medium, 'Medium'),
                const SizedBox(width: 12),
                _buildPriorityChip(TaskPriority.low, 'Low'),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriorityChip(TaskPriority priority, String label) {
    final isSelected = selectedPriority == priority;
    
    return GestureDetector(
      onTap: () => onPrioritySelected(priority),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 15),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[800] :Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(8),
         
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  String _getPriorityLabel(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.high:
        return 'High';
      case TaskPriority.medium:
        return 'Medium';
      case TaskPriority.low:
        return 'Low';
    }
  }
}