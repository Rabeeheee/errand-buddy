import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'core/network/network_info.dart';
import 'features/tasks/data/datasources/task_remote_data_source.dart';
import 'features/tasks/data/repositories/task_repository_impl.dart';
import 'features/tasks/domain/repositories/task_repository.dart';
import 'features/tasks/domain/usecases/create_task.dart';
import 'features/tasks/domain/usecases/delete_task.dart';
import 'features/tasks/domain/usecases/get_tasks.dart';
import 'features/tasks/domain/usecases/get_overdue_tasks.dart';
import 'features/tasks/domain/usecases/update_task.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';

import 'features/members/data/datasources/member_remote_data_source.dart';
// Add members repo + use cases etc. if needed

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Tasks

  // Bloc
  sl.registerFactory(() => TaskBloc(
        createTask: sl(),
        getTasks: sl(),
        deleteTask: sl(),
        updateTask: sl(),
        getOverdueTasks: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => GetTasks(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => GetOverdueTasks(sl()));

  // Repository
  sl.registerLazySingleton<TaskRepository>(() => TaskRepositoryImpl(
        remoteDataSource: sl(),
      ));

  // Data sources
  sl.registerLazySingleton<TaskRemoteDataSource>(
      () => TaskRemoteDataSourceImpl(firestore: sl()));

  //! Features - Members
  sl.registerLazySingleton<MemberRemoteDataSource>(
      () => MemberRemoteDataSourceImpl(firestore: sl()));
  // Add members repo + use cases if you implement them

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() =>
      NetworkInfoImpl(connectionChecker: sl()));

  //! External
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

}
