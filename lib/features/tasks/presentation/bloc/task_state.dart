import 'package:equatable/equatable.dart';
import '../../domain/entities/task.dart';

abstract class TaskState extends Equatable {
  const TaskState();
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}
class TaskLoading extends TaskState {}
class TasksLoaded extends TaskState {
  final List<Task> tasks;
  const TasksLoaded(this.tasks);
  @override
  List<Object?> get props => [tasks];
}

class OverdueTasksLoaded extends TaskState {
  final List<Task> overdueTasks;
  const OverdueTasksLoaded(this.overdueTasks);
  @override
  List<Object?> get props => [overdueTasks];
}

class TaskError extends TaskState {
  final String message;
  const TaskError(this.message);
  @override
  List<Object?> get props => [message];
}
