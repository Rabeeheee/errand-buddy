import 'package:flutter/material.dart';

class TaskFabWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const TaskFabWidget({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
      tooltip: 'Add Task',
    );
  }
}