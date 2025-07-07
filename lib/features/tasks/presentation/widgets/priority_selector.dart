import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/priority_utils.dart';

class PrioritySelector extends StatelessWidget {
  final TaskPriority selectedPriority;
  final Function(TaskPriority) onPriorityChanged;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.onPriorityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: TaskPriority.values.map((priority) {
        final isSelected = priority == selectedPriority;
        return Expanded(
          child: GestureDetector(
            onTap: () => onPriorityChanged(priority),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? _getPriorityColor(priority) : AppColors.background,
                border: Border.all(
                  color: _getPriorityColor(priority),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                priority.name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: isSelected ? Colors.white : _getPriorityColor(priority),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // helper to choose color
  Color _getPriorityColor(TaskPriority priority) {
    switch (priority) {
      case TaskPriority.low:
        return Colors.green;
      case TaskPriority.medium:
        return Colors.orange;
      case TaskPriority.high:
        return Colors.red;
    }
  }
}
