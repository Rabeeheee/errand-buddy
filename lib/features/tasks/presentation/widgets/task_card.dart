import 'package:errand_buddy/features/tasks/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showTaskDetails(context),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPriorityText(),
                      const SizedBox(height: 4),
                      Text(
                        task.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                     
                      const SizedBox(height: 4),
                      Text(
                        _formatDueDate(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (task.imageUrl != null && task.imageUrl!.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  _buildTaskImage(),
                ],
              ],
            ),
            SizedBox(height: 15,)
           
          ],
        ),
      ),
    );
  }

  Widget _buildPriorityText() {
    if (task.priority == null) return const SizedBox.shrink();
    
    return Text(
      '${task.priority} Priority',
      style: const TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildTaskImage() {
    return Container(
      width: 120,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: task.imageUrl!,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[300],
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'No Image',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

 

  String _formatDueDate() {
    final now = DateTime.now();
    final difference = task.dueDate.difference(now).inDays;
    
    if (difference == 0) {
      return 'Due: Today';
    } else if (difference == 1) {
      return 'Due: Tomorrow';
    } else if (difference == -1) {
      return 'Due: Yesterday';
    } else if (difference > 1) {
      return 'Due: $difference Days';
    } else {
      return 'Due: ${difference.abs()} Days Ago';
    }
  }

  void _showTaskDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (task.imageUrl != null && task.imageUrl!.isNotEmpty)
              Container(
                width: double.infinity,
                height: 200,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: task.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text(
                          'Failed to load image',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            Text('Assigned to: ${task.assignedToName}'),
            const SizedBox(height: 8),
            Text('Due: ${_formatDueDate()}'),
            const SizedBox(height: 8),
            if (task.priority != null)
              Text('Priority: ${task.priority}'),
            const SizedBox(height: 8),
            Text('Status: ${task.isCompleted ? 'Completed' : 'Pending'}'),
            if (task.escalationCount > 0) ...[
              const SizedBox(height: 8),
              Text('Escalations: ${task.escalationCount}'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}