import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:errand_buddy/features/escalation/presentation/bloc/escalation_bloc.dart';
import 'package:errand_buddy/features/members/presentation/bloc/member_bloc.dart';
import 'package:errand_buddy/features/tasks/data/datasources/task_remote_data_source.dart';
import 'package:errand_buddy/features/tasks/data/model/assigne_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'injection_container.dart' as di;
import 'core/constants/app_colors.dart';
import 'core/routes/app_router.dart';
import 'features/tasks/presentation/bloc/task_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();

  // 👉 Add initial assignees only once (safe to keep, will skip if already exists)
  final firestore = FirebaseFirestore.instance;
  final assigneeDataSource = TaskRemoteDataSourceImpl(firestore: firestore);

  final existingAssignees = await assigneeDataSource.getAllAssignees();
  if (existingAssignees.isEmpty) {
    final assignees = [
      AssigneeModel(id: '1', name: 'Liam', avatar: 'assets/images/assignee1.png'),
      AssigneeModel(id: '2', name: 'Ethan', avatar: 'assets/images/assignee2.png'),
      AssigneeModel(id: '3', name: 'Sophia', avatar: 'assets/images/assignee3.png'),
    ];
    for (final assignee in assignees) {
      await assigneeDataSource.addAssignee(assignee);
    }
    debugPrint('Initial assignees added to Firestore');
  } else {
    debugPrint('Assignees already exist, skip adding');
  }

  runApp(const ErrandBuddyApp());
}


class ErrandBuddyApp extends StatelessWidget {
  const ErrandBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<TaskBloc>()),
        BlocProvider(create: (_) => di.sl<MembersBloc>()),
        BlocProvider(create: (_) => di.sl<EscalationBloc>()),
      ],
      child: MaterialApp.router(
        theme: ThemeData(
          textTheme: GoogleFonts.plusJakartaSansTextTheme(
      Theme.of(context).textTheme,),
          primarySwatch: Colors.blue,
          primaryColor: AppColors.primary,
          fontFamily: 'Playpen Sans',
          scaffoldBackgroundColor: AppColors.background,
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            elevation: 0,
          ),
        ),
        routerConfig: AppRouter.router,
      ),
    );
  }
}