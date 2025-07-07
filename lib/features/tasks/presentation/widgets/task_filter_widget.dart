import 'package:errand_buddy/features/tasks/presentation/widgets/flutter_chip_widget.dart';
import 'package:flutter/material.dart';

enum TaskFilter { all, overdue }

class TaskFilterWidget extends StatelessWidget {
  final Function(TaskFilter) onFilterChanged;

  const TaskFilterWidget({
    Key? key,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: FilterChipWidget(
              label: 'All Tasks',
              icon: Icons.list,
              isSelected: true, // You can manage this state through BLoC if needed
              onSelected: () => onFilterChanged(TaskFilter.all),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilterChipWidget(
              label: 'Overdue',
              icon: Icons.warning,
              isSelected: false,
              onSelected: () => onFilterChanged(TaskFilter.overdue),
            ),
          ),
        ],
      ),
    );
  }
}