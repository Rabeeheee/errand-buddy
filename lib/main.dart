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
  runApp(const ErrandBuddyApp());
}

class ErrandBuddyApp extends StatelessWidget {
  const ErrandBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<TaskBloc>()),
        // BlocProvider(create: (_) => di.sl<MemberBloc>()),
        // BlocProvider(create: (_) => di.sl<EscalationBloc>()),
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