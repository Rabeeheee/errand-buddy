import 'package:flutter/material.dart';

class TaskLoadingWidget extends StatelessWidget {
  const TaskLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading tasks...'),
        ],
      ),
    );
  }
}