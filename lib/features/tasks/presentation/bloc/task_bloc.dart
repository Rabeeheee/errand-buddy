import 'package:flutter_bloc/flutter_bloc.dart';
import 'task_event.dart';
import 'task_state.dart';
import '../../domain/usecases/create_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/get_overdue_tasks.dart';
import '../../domain/usecases/get_tasks.dart';
import '../../domain/usecases/update_task.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTasks getTasks;
  final CreateTask createTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final GetOverdueTasks getOverdueTasks;

  TaskBloc({
    required this.getTasks,
    required this.createTask,
    required this.updateTask,
    required this.deleteTask,
    required this.getOverdueTasks,
  }) : super(TaskInitial()) {
    on<LoadTasks>((event, emit) async {
      emit(TaskLoading());
      final result = await getTasks();
      result.fold(
        (failure) => emit(TaskError('Failed to load tasks')),
        (tasks) => emit(TasksLoaded(tasks)),
      );
    });

    on<LoadOverdueTasks>((event, emit) async {
      emit(TaskLoading());
      final result = await getOverdueTasks();
      result.fold(
        (failure) => emit(TaskError('Failed to load overdue tasks')),
        (tasks) => emit(OverdueTasksLoaded(tasks)),
      );
    });

    on<AddTask>((event, emit) async {
      emit(TaskLoading());
      final result = await createTask(event.task);
      result.fold(
        (failure) => emit(TaskError('Failed to add task')),
        (_) => add(LoadTasks()),
      );
    });

    on<UpdateTaskEvent>((event, emit) async {
      emit(TaskLoading());
      final result = await updateTask(event.task);
      result.fold(
        (failure) => emit(TaskError('Failed to update task')),
        (_) => add(LoadTasks()),
      );
    });

    on<DeleteTaskEvent>((event, emit) async {
      emit(TaskLoading());
      final result = await deleteTask(event.taskId);
      result.fold(
        (failure) => emit(TaskError('Failed to delete task')),
        (_) => add(LoadTasks()),
      );
    });
  }
}
