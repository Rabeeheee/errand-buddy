import 'package:errand_buddy/core/widgets/main_wraper.dart';
import 'package:go_router/go_router.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
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
        builder: (context, state) => OnboardingPage(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) {
          final indexString = state.uri.queryParameters['index'];
          final index = int.tryParse(indexString ?? '1') ?? 1;
          return MainWrapper(initialIndex: index);
        },
      ),
      GoRoute(
        path: '/members',
        redirect: (context, state) => '/main?index=0',
      ),
      GoRoute(
        path: '/tasks',
        redirect: (context, state) => '/main?index=1',
      ),
      GoRoute(
        path: '/escalation',
        redirect: (context, state) => '/main?index=2',
      ),
      GoRoute(
        path: '/profile',
        redirect: (context, state) => '/main?index=3',
      ),
      GoRoute(
        path: '/add-task',
        builder: (context, state) => const AddTaskPage(),
      ),
    ],
  );
}