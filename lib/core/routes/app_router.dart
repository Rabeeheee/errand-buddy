import 'package:errand_buddy/features/escalation/presentation/pages/escalation_page.dart';
import 'package:errand_buddy/features/members/presentation/pages/member_page.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/tasks/presentation/pages/add_task_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) =>  OnboardingPage(),
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => const TasksPage(),
      ),
      GoRoute(
        path: '/add-task',
        builder: (context, state) => const AddTaskPage(),
      ),
      GoRoute(
        path: '/members',
        builder: (context, state) => const MembersPage(),
      ),
      GoRoute(
        path: '/escalation',
        builder: (context, state) => const EscalationPage(),
      ),
    ],
  );
}
